class Composer

  def initialize(images)
    @images = images
  end

  def generate(note)
    elements = []
    word_count = -1

    partition(note).each do |line|
      line.each do |images|
        elements << word(images.collect { |image| image.url }).at(word_count += 1)
        elements << space
      end
      elements.pop # Remove extra space from last element
      elements << line_break
    end

    elements.pop # Remove extra line break from last element
    note(elements)
  end

  private

  def partition(note)
    note.downcase.split("\n").collect do |line|
      line.split(/\s/).collect do |word|
        word.split("").collect do |character|
          first_image_for(character)      
        end.compact
      end.reject { |item| item.empty? }
    end.reject { |item| item.empty? }
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

  def line_break
    Element.break
  end

end
