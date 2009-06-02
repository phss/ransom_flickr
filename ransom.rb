require 'rubygems'
require "ransom_flickr"
require 'sinatra'
require "haml"
require "sass"

get '/' do
  # message = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  message = "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
  @photo_urls = RansomFlickr.new("flickr_key.yaml").get_photo_urls(message)
  haml :view
end

get '/ransom_flickr.css' do
   content_type 'text/css', :charset => 'utf-8'
   sass :ransom_flickr
end
