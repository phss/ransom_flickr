require "rubygems"
require "sinatra"

get "/" do
 haml :homepage
end