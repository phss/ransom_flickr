class Image

  attr_reader :image_id, :url, :character

  def initialize(image_id, url, character = nil)
    @image_id, @url, @character = image_id, url, character
  end

  def self.from_db(db_hash)
    Image.new(db_hash["image_id"], db_hash["image_url"], db_hash["character"])
  end

  def with_character(character)
    @character = character
    self
  end

  def ==(another_image)
    @image_id == another_image.image_id
  end

end