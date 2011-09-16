class Composer

  def initialize(images)
    @images = images
  end

  def generate(note)
    note.downcase.split("").inject([]) do |word, character|
      word << first_image_for(character)
    end
  end

  private

  def first_image_for(character)
    character = Punctuation.match(character) ? Punctuation.for(character).name : character
    Images.find_for(character).first
  end

end