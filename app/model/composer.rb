class Composer

  def initialize(images)
    @images = images
  end

  def generate(note)
    elements = []
    word_count = 0
    current_word = []

    note.downcase.split("").each do |character|
      if (character.match(/\s/) || character == "\n")
        unless current_word.empty?
          elements << word(current_word).at(word_count)
          current_word = []
          word_count += 1
        end
        elements << space if character == " "
        elements << line_break if character == "\n"
      else
        image = first_image_for(character)
        current_word << image.url unless image.nil?
      end
    end

    unless current_word.empty?
      elements << word(current_word).at(word_count)
      current_word = []
      word_count += 1
    end

    note(elements)
  end

  private

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
