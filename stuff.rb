require "rubygems"
require "flickr"
require "net/http"

flickr = Flickr.new("blah")
puts Net::HTTP.get_response(URI.parse(flickr.request_url("blah")))
#puts flickr.users("paulo.schneider@gmail.com").name
