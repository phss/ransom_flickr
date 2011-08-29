require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "yaml"
require_relative "model/images"
require_relative "model/image"
require_relative "../lib/helpers"
require_relative "../lib/flickr"

helpers Authentication

DB = Mongo::Connection.new.db("ransom")
Images.db_collection = DB.collection("images")

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

  @to_add_images = settings.image_service.browse(params[:character])
  @saved_images = Images.find_for(params[:character])

  haml :admin
end

get "/admin/save/:character/:image_id" do
  protected!
  
  Images.save(params[:character], settings.image_service.find_image(params[:image_id]))

  redirect "/admin/browse/#{params[:character]}"
end


# Stylesheet link
get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end
