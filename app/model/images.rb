require "mongo"

class Images
  @@collection = nil

  def self.db_collection=(collection)
    @@collection = collection
  end
  
  def self.save(image)
    require_character(image)
    
    collection.save(image.to_hash)
  end

  def self.remove(image)
    require_character(image)

    collection.remove(image.to_hash)
  end

  def self.saved?(image)
    collection.find(:image_id => image.image_id).has_next?
  end

  def self.find_for(character)
    collection.find(:character => character).to_a.collect { |image_hash| Image.from_db(image_hash) }
  end

  private

  def self.collection
    raise "No underlying DB collection" unless @@collection

    return @@collection
  end

  def self.require_character(image)
    raise "Missing character" unless image.character
  end

end