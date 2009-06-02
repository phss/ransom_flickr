require "ransom_flickr"

flickr = RansomFlickr.new("flickr_key.yaml")
puts flickr.get(flickr, "b").source('Square')
puts flickr.get(flickr, "l").source('Square')
flickr.get(flickr, "a")
flickr.get(flickr, "h")
