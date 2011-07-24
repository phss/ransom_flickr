require "rubygems"
require "sinatra"
require "haml"

get "/" do
 haml :homepage
end

get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end