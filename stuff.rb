require "rubygems"
require "flickr"
require "yaml"

def get(flickr, letter)
  photo = flickr.photos(:tags => "oneletter, #{letter}", :tag_mode => "all", :per_page => "1").first
  # File.open(photo.filename, 'w') { |file| file.puts photo.file('Square') }
end

config = YAML.load_file("flickr_key.yaml")

flickr = Flickr.new(config["key"])
get(flickr, "b")
get(flickr, "l")
get(flickr, "a")
get(flickr, "h")