class Composer

  def initialize(images)
    @images = images
  end

  def generate(note)
    note.split("").inject([]) do |word, character|
      word << @images.find_for(character).first
    end
  end

  
end