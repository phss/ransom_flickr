require 'rubygems'
require "ransom_flickr"
require 'sinatra'
require "haml"
require "sass"

get '/' do
  message = "Ransom is the practice of holding a prisoner to extort money or property to secure their release, or it can refer to the sum of money involved."
  @photo_urls = RansomFlickr.new("flickr_key.yaml").get_photo_urls(message)
  haml :view
end

get '/ransom_flickr.css' do
   content_type 'text/css', :charset => 'utf-8'
   sass :ransom_flickr
end
