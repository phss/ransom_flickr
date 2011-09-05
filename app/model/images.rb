require "mongo"

class Images
  @@collection = nil

  def self.db_collection=(collection)
    @@collection = collection
  end
  
  def self.save(image)
    raise "Missing character" unless image.character
    collection.save("character" => image.character, "image_url" => image.url, "image_id" => image.image_id)
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

end