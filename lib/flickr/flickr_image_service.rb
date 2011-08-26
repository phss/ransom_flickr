class FlickrImageService

  def initialize(flickr_wrapper)
    @flickr_wrapper = flickr_wrapper
  end

  def browse(character)
    flickr_photos = @flickr_wrapper.search(:tag => character, :group => "One Letter")
    return flickr_photos.collect { |photo| photo.url_sq }
  end

end