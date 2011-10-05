require "mongo"

class Notes
  @@collection = nil

  def self.db_collection=(collection)
    @@collection = collection
  end

  def self.save(note)
    collection.save("key" => "aaa", "note" => note)
  end

  private

  def self.collection
    raise "No underlying DB collection" unless @@collection

    return @@collection
  end
  
end