require "mongo"

class Notes
  @@collection = nil
  @@key_generator = nil

  def self.db_collection=(collection)
    @@collection = collection
  end

  def self.key_generator=(generator)
    @@key_generator = generator
  end

  def self.save(note)
    raise "No key generator" unless @@key_generator
    collection.save("key" => @@key_generator.next_key, "note" => note)
  end

  private

  def self.collection
    raise "No underlying DB collection" unless @@collection

    return @@collection
  end
  
end