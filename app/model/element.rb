class Element
  attr_reader :type, :elements

  def initialize(type, elements=[])
    @type = type
    @elements = elements
  end

  def self.note_with(elements)
    Element.new(:note, elements)
  end

  def self.word_with(urls)
    Element.new(:word, urls)
  end

  def ==(another_element)
    @type == another_element.type && @elements == another_element.elements
  end

end
