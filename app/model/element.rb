class Element
  attr_reader :type, :elements

  def initialize(type, elements=[])
    @type = type
    @elements = elements
  end

  def ==(another_element)
    @type == another_element.type && @elements == another_element.elements
  end

end
