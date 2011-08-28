class FakeImageService

  def initialize(images_hash)
    @images_hash = images_hash
  end

  def browse(character)
    @images_hash.find_all { |image| image[:Character] == character }.collect { |image| FlickrImage.new(image["Image ID"], image[:Image]) }
  end

  def find_image(image_id)
    image_hash = @images_hash.find { |image| image["Image ID"] == image_id }
    return FlickrImage.new(image_hash["Image ID"], image_hash[:Image])
  end

end