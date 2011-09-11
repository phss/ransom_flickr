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

DB = Mongo::Connection.new.db("ransom")
Images.db_collection = DB.collection("images")

enable :sessions
use Rack::Flash

configure :production, :development do
  set :image_service, FlickrImageService.new(FlickWrapper.new(YAML.load_file("flickr_key.yaml")))
end

get "/" do
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
