require "ransom_flickr"

flickr = RansomFlickr.new("flickr_key.yaml")
puts flickr.get("b").source('Square')
puts flickr.get("l").source('Square')
flickr.get("a")
flickr.get("h")
