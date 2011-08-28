require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "yaml"
require "mongo"
require_relative "../lib/helpers"
require_relative "../lib/flickr"

helpers Authentication

DB = Mongo::Connection.new.db("ransom")

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
  @saved_images = DB.collection("images").find({:character => params[:character]})
  haml :admin
end

get "/admin/save/:character/:image_id" do
  protected!
  
  image = settings.image_service.find_image(params[:image_id])

  DB.collection("images").save({ "character" => params[:character], "image_url" => image.url, "image_id" => image.image_id })

  @to_add_images = settings.image_service.browse(params[:character])
  @saved_images = DB.collection("images").find({:character => params[:character]})
  haml :admin
end

get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end
