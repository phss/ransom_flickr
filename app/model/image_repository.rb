require "mongo"

class ImageRepository

  def initialize(collection)
    @collection = collection
  end
  
  def save(image)
    require_character(image)
    
    @collection.save(image.to_hash)
  end

  def remove(image)
    require_character(image)

    @collection.remove(image.to_hash)
  end

  def saved?(image)
    @collection.find(:image_id => image.image_id).has_next?
  end

  def find_for(character)
    @collection.find(:character => character).to_a.collect { |image_hash| Image.from_db(image_hash) }
  end

  private

  def require_character(image)
    raise "Missing character" unless image.character
  end

end