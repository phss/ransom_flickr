require File.dirname(__FILE__) + "/../../spec_helper"

describe Composer do

  before do
    @images = double("Flickr Wrapper")
    @composer = Composer.new(@images)
    srand(42) # Sets seed as the to have predictable results
  end

  describe "(single word)" do
    it "should generate note with random image of each character" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")],
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]

      @composer.generate("abc").should == note_with(word("a1", "b2", "c2").at(0))
    end

    it "should generate note ignoring case" do
      images_should_have "a" => [Image.new("a1", "a1")]

      @composer.generate("aA").should == note_with(word("a1", "a1").at(0))
    end

    it "should ignore characters where no image is available" do
      images_should_have "a" => [Image.new("a1", "a1")],
                         "b" => [] # No image


      @composer.generate("aba").should == note_with(word("a1", "a1").at(0))
    end

    it "should rotate character's images when multiples occurences" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")]

      @composer.generate("aaabb").should == note_with(word("a1", "a2", "a1", "b2", "b1").at(0))
    end    
  end

  describe "(punctuation)" do
    Punctuation.list.each do |punctuation|
      it "should generate note for #{punctuation.symbol} character" do
        punctuation_image = Image.new(punctuation.name, punctuation.name)
        images_should_have punctuation.name => [punctuation_image]

        @composer.generate(punctuation.symbol).should == note_with(word(punctuation.name).at(0))
      end
    end
  end

  describe "(multiple words)" do
    it "should generate note with multiple words" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")],
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]
      
      @composer.generate("a b c").should == note_with(word("a1").at(0), space, word("b2").at(1), space, word("c2").at(2))
    end

    it "should generate note with multiple words" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [], # No images
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]

      @composer.generate("a b c").should == note_with(word("a1").at(0), space, word("c2").at(1))
    end    
  end

  describe "(line breaks)" do
    it "should generate note with line break" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")],
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]
      
      @composer.generate("a\nb\nc").should == note_with(word("a1").at(0), line_break, word("b2").at(1), line_break, word("c2").at(2))      
    end
  end


  def images_should_have(expected_image_map)
    expected_image_map.each do |character, expected_results|
      @images.stub(:find_for).with(character).and_return(expected_results)
    end
  end

  def note_with(*elements)
    Element.note_with(elements)
  end

  def word(*urls)
    Element.word_with(urls)
  end

  def space
    Element.space
  end

  def line_break
    Element.break
  end
end
