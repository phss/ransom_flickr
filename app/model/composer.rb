class Composer

  def initialize(images)
    @images = images
    @cache = {}
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
          image_for(character)      
        end.compact
      end.reject { |item| item.empty? }
    end.reject { |item| item.empty? }
  end

  def image_for(character)
    unless @cache.has_key?(character)
      @cache[character] = @images.find_for(Punctuation.or(character)).sort_by { rand }
    end    
    image = @cache[character].first
    @cache[character].rotate!
    return image
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
