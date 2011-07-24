require "rubygems"
require "sinatra"
require "haml"
require File.dirname(__FILE__) + "/../lib/helpers"

helpers Authentication

get "/" do
 haml :homepage
end

get "/admin" do
  protected!
  "Admin"
end

get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end