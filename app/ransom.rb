require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "yaml"
require_relative "model/images"
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
  
  image = settings.image_service.find_image(params[:image_id])
  Images.save(params[:character], image)

  redirect "/admin/browse/#{params[:character]}"
end

get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end
