class Composer

  def initialize(images)
    @images = images
  end

  def generate(note)
    elements = []
    pre_generate(note).each_with_index do |images, i|
      elements << word(images.collect { |image| image.url}).at(i)
      elements << space
    end
    elements.pop
    note(elements)
  end

  private

  def pre_generate(note)
    note.downcase.split(/\s/).collect do |word|
      word.split("").collect do |character|
        first_image_for(character)
      end.compact
    end.reject { |word| word.empty? }
  end

  def first_image_for(character)
    character = Punctuation.match(character) ? Punctuation.for(character).name : character
    @images.find_for(character).first
  end

  def note(elements)
    Element.note_with(elements)
  end

  def word(urls)
    Element.word_with(urls)
  end

  def space
    Element.space
  end

end
