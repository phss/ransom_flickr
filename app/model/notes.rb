require "mongo"

class Notes
  @@collection = nil
  @@key_generator = nil

  def self.db_collection=(collection)
    @@collection = collection
  end

  def self.key_generator=(key_generator)
    @@key_generator = key_generator
  end

  def self.save(note_text)
    note = {"key" => generator.next, "note" => note_text}
    collection.save(note)
    return note
  end

  private

  def self.collection
    raise "No underlying DB collection" unless @@collection

    return @@collection
  end

  def self.generator
    raise "No key generator" unless @@key_generator

    @@key_generator
  end
  
end