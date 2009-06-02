require "rubygems"
require "flickr"
require "yaml"
 
class RansomFlickr
 
  def initialize(config_file)
    config = YAML.load_file(config_file)
    @flickr = Flickr.new(config["key"])
  end
 
  def get(letter)
    @flickr.photos(:tags => "oneletter, #{letter}", :tag_mode => "all", :per_page => "1").first
  end
  
end