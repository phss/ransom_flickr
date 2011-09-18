class Punctuation
  attr_reader :symbol, :name

  def self.list
    [Punctuation.new(".", "period"),
     Punctuation.new("!", "exclamation"),
     Punctuation.new("?", "question mark"),
     Punctuation.new(",", "comma"),
     Punctuation.new(";", "semicolon"),
     Punctuation.new("&", "ampersand"),
     Punctuation.new("-", "dash"),
     Punctuation.new(":", "colon")]
  end

  def self.match(character)
    Punctuation.for(character) != nil
  end

  def self.for(character)
    list.find { |punctuation| punctuation.name == character || punctuation.symbol == character }
  end

  # Returns a punctuation name, if it's a punctiation symbolr, or the supplied character otherwise.
  def self.or(character)
    Punctuation.match(character) ? Punctuation.for(character).name : character
  end

  private

  def initialize(symbol, name)
    @symbol, @name = symbol, name
  end

end