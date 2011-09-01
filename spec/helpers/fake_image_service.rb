class FakeImageService

  def initialize(images_hash, max_per_page=5)
    @images_hash = images_hash
    @max_per_page = max_per_page
  end

  def browse(character, page)
    character_images = @images_hash.find_all { |image| image[:Character] == character }
    page_index_start = (page - 1) * @max_per_page
    character_images[page_index_start..page_index_start+@max_per_page-1].collect { |image| Image.new(image["Image ID"], image[:Image], character) }
  end

  def find_image(image_id)
    image_hash = @images_hash.find { |image| image["Image ID"] == image_id }
    return Image.new(image_hash["Image ID"], image_hash[:Image])
  end

end