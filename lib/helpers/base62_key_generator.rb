require "base62"

class Base62KeyGenerator

  def initialize(collection, category, base_sequence_number)
    @collection, @category, @base_sequence_number = collection, category, base_sequence_number
  end

  def next
    value = @collection.find_and_modify(:query => {"_id" => @category}, :update => {"$inc" => { "next" => 1 }}, :upsert => true)
    (@base_sequence_number + value["next"]).base62_encode
  end
  
end