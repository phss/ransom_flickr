require "mongo"

class NoteRepository
  
  def initialize(collection, key_generator)
    @collection, @key_generator = collection, key_generator
  end

  def save(note_text)
    note = {"key" => @key_generator.next, "note" => note_text}
    @collection.save(note)
    return note
  end

  def find_by_key(key)
    @collection.find_one("key" => key)
  end
  
end