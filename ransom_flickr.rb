require "lib/vendor/moonpxi-flickr/lib/flickr"
require "yaml"
 
class RansomFlickr
 
  def initialize(config_file)
    @flickr = Flickr.new(YAML.load_file(config_file)["key"])
    @url_cache = Hash.new
    @punctuation_map = {
      "!" => "exclamation",
      "." => "period",
      "," => "comma",
      ";" => "semicolon",
      "?" => "question mark",
      "-" => "dash",
      ":" => "colon"
    }
  end

	def preload
		fetcher = lambda { |char| get_url_for(char.to_s) }
		'a'.upto('z', &fetcher)
	  0.upto(9, &fetcher)
		@punctuation_map.keys.each(&fetcher)
	end
  
  def get_photo_urls(message)
    message.downcase.split(/\s/).map do |word|
      word.split("").inject([]) do |photo_word, letter|
        photo_word << get_url_for(letter)
      end.compact
    end
  end
  
	private

  def get_url_for(char)
    unless @url_cache.has_key?(char)
      if char.match(/[A-Za-z]/)
        @url_cache[char] = fetch(char, "oneletter")
      elsif char.match(/[0-9]/)
        @url_cache[char] = fetch(char, "onedigit")
      elsif @punctuation_map.has_key?(char)
        @url_cache[char] = fetch(@punctuation_map[char], "punctuation")
      else
        @url_cache[char] = [nil]
      end
    end
    urls = @url_cache[char]
    return urls[rand(urls.size)]
  end
  
  def fetch(char, group)
    @flickr.photos(:tags => "#{group}, #{char}", :tag_mode => "all", :per_page => "1").map { |photo| photo.source("Square") }
  end
  
end
