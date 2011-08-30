class FlickrImageService

  def initialize(flickr_wrapper)
    @flickr_wrapper = flickr_wrapper
  end

  def browse(character)
    flickr_photos = @flickr_wrapper.search(:tag => character, :group => "One Letter")
    return flickr_photos.collect { |photo| Image.from_flickr(photo).with_character(character) }
  end

  def find_image(image_id)
    return Image.new(image_id, @flickr_wrapper.fetch_url(image_id))
  end

end