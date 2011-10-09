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

configure :production, :development do
  set :image_service, FlickrImageService.new(FlickWrapper.new(YAML.load_file("flickr_key.yaml")))
end

configure do
  DB = Mongo::Connection.new.db("ransom-#{settings.environment}")
  Images = ImageRepository.new(DB.collection("images"))
  Notes = NoteRepository.new(DB.collection("notes"), Base62KeyGenerator.new(DB.collection("sequences"), "key", 300779))

  enable :sessions
  use Rack::Flash
end

helpers Authentication, Pagination, PartialRendering, ImageStyle do
  def compose(note)
    Composer.new(Images).generate(note)
  end
end

# Generating notes
get "/" do
 haml :homepage
end

post "/generate" do
  @image_note = compose(params[:note])

  haml :homepage
end

post "/save" do
  saved_note = Notes.save(params[:note])

  flash[:save_status] = "Note saved. Copy the url and send it to your 'friends'."

  redirect "/note/#{saved_note["key"]}"
end

get "/note/:key" do
  saved_note = Notes.find_by_key(params[:key])
  return "Note for key '#{params[:key]}' doesn't exist." unless saved_note
  
  @image_note = compose(saved_note["note"])

  haml :note
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
