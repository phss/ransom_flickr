class FlickrImageService

  def initialize(flickr_wrapper)
    @flickr_wrapper = flickr_wrapper
  end

  def browse(character, page = 1)
    flickr_photos = @flickr_wrapper.search(:tag => character, :group => group_for(character), :page => page)
    return flickr_photos.collect { |photo| Image.from_flickr(photo).with_character(character) }
  end

  def find_image(image_id)
    return Image.new(image_id, @flickr_wrapper.fetch_url(image_id))
  end

  private

  def group_for(character)
    if Punctuation.match(character)
      "Punctuation"
    elsif character.match(/[A-Za-z]/)
      "One Letter"
    elsif character.match(/[0-9]/)
      "One Digit"
    else
      raise "No character group for #{character}"
    end
  end

end