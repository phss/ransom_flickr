require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "yaml"
require "rack-flash"
require "uri"
require_relative "model"
require_relative "../lib/helpers"
require_relative "../lib/flickr"

helpers Authentication, Pagination, PartialRendering

configure :production, :development do
  set :image_service, FlickrImageService.new(FlickWrapper.new(YAML.load_file("flickr_key.yaml")))
end

configure do
  DB = Mongo::Connection.new.db("ransom-#{settings.environment}")
  Images.db_collection = DB.collection("images")

  enable :sessions
  use Rack::Flash
end


# Generating notes
get "/" do
 haml :homepage
end

post "/generate" do
  note_words = params[:note].downcase.split(/\s/)

  @words = note_words.collect do |word|
    word.split("").inject([]) do |photo_word, character|
      if Punctuation.match(character)
        photo_word << Images.find_for(Punctuation.for(character).name).first
      else
        photo_word <<Images.find_for(character).first
      end
      photo_word
    end.compact
  end.compact

  haml :homepage
end

# Admin routes
get "/admin" do
  protected!
  haml :admin
end

get "/admin/browse/:character" do
  protected!

  @to_add_images = settings.image_service.browse(params[:character], current_page)
  @saved_images = Images.find_for(params[:character])

  haml :admin
end

get "/admin/:action/:character/:image_id" do
  protected!

  action = params[:action]
  halt "Action #{action} not supported" unless ["save", "remove"].include?(action)
  
  Images.send(action, settings.image_service.find_image(params[:image_id]).with_character(params[:character]))
  flash[:save_status] = "#{action.capitalize} successful"

  redirect link_with_pagination("/admin/browse/#{URI.escape(params[:character])}")
end

# Stylesheet link
get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end
