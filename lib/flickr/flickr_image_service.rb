class FlickrImageService

  def initialize(flickr_wrapper)
    @flickr_wrapper = flickr_wrapper
  end

  def browse(character)
    @flickr_wrapper.search(character, :group => "oneletter").collect { |photo| photo.url_sq }
  end

end