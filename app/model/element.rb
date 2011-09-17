class Element
  attr_reader :type, :elements, :position

  def initialize(type, elements=[])
    @type, @elements = type, elements
    @position = nil
  end

  def self.note_with(elements)
    Element.new(:note, elements)
  end

  def self.word_with(urls)
    Element.new(:word, urls)
  end

  def at(position)
    @position = position
  end

  def ==(another_element)
    @type == another_element.type && @elements == another_element.elements && @position == another_element.position
  end

end
