class Composer

  def initialize(images)
    @images = images
  end

  def generate(note)
    note.downcase.split(/\s/).collect do |word|
      word.split("").collect do |character|
        first_image_for(character)
      end.compact
    end
  end

  private

  def first_image_for(character)
    character = Punctuation.match(character) ? Punctuation.for(character).name : character
    @images.find_for(character).first
  end

end