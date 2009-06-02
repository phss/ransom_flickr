require 'rubygems'
require "ransom_flickr"

require 'sinatra'
get '/' do
  flickr = RansomFlickr.new("flickr_key.yaml")  
  return getimg("i blame jason now") 
end

def getimg(message)
  flickr = RansomFlickr.new("flickr_key.yaml")
  html = ""
  message.split("").each do |letter|
    if letter != " "
      html += "<img src=\"#{flickr.get(letter).source('Square')}\" />"
    else
      html += "<br/>"
    end
  end
  return html
end
