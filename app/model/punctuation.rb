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
    list.find { |punctuation| punctuation.name == character }
  end

  private

  def initialize(symbol, name)
    @symbol, @name = symbol, name
  end

end