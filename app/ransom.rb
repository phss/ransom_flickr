require "rubygems"
require "sinatra"
require "haml"
require "sass"
require_relative "../lib/helpers"

helpers Authentication

get "/" do
 haml :homepage
end

get "/admin" do
  protected!
  haml :admin
end

get "/admin/browse/:character" do
  protected!
  @image_urls = settings.image_service.browse(params[:character])
  haml :browse_character
end

get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end
