class Composer

  def initialize(images)
    @images = images
  end

  def pre_generate(note)
    note.downcase.split(/\s/).collect do |word|
      word.split("").collect do |character|
        first_image_for(character)
      end.compact
    end.reject { |word| word.empty? }
  end

  def generate(note)
    first_word = pre_generate(note).first
    note(word(first_word.collect { |image| image.url}).at(0))
  end

  private

  def first_image_for(character)
    character = Punctuation.match(character) ? Punctuation.for(character).name : character
    @images.find_for(character).first
  end

  def note(*elements)
    Element.note_with(elements)
  end

  def word(urls)
    Element.word_with(urls)
  end

end
