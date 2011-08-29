require "mongo"

class Images
  @@collection = nil

  def self.db_collection=(collection)
    @@collection = collection
  end
  
  def self.save(character, image)
    collection.save({ "character" => character, "image_url" => image.url, "image_id" => image.image_id })
  end

  def self.find_for(character)
    collection.find(:character => character).to_a
  end

  private

  def self.collection
    raise "No underlying DB collection" unless @@collection

    return @@collection
  end

end