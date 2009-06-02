require "rubygems"
require "flickr"
require "yaml"
 
class RansomFlickr
 
  def initialize(config_file)
    @flickr = Flickr.new(YAML.load_file(config_file)["key"])
  end
 
  def get(letter)
    @flickr.photos(:tags => "oneletter, #{letter}", :tag_mode => "all", :per_page => "1").first
  end
  
  def get_photo_urls(message)
    message.split("").map do |letter|
      if letter.match(/[A-Za-z]/)
        get(letter).source("Square")
      else
        nil
      end
    end
  end
  
end