require File.dirname(__FILE__) + "/../../spec_helper"

describe Composer do

  before do
    @images = double("Flickr Wrapper")
    @composer = Composer.new(@images)
  end

  describe "(single word)" do
    it "should generate note with first image of each character" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")],
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]

      @composer.generate("abc").should == [[Image.new("a1", "a1"), Image.new("b1", "b1"), Image.new("c1", "c1")]]
      # @composer.generate2("abc").should be_note_with(word("a1", "b1", "c1"), space(), line)
    end

    it "should generate note ignoring case" do
      images_should_have "a" => [Image.new("a1", "a1")]

      @composer.generate("aA").should == [[Image.new("a1", "a1"), Image.new("a1", "a1")]]
    end

    it "should ignore characters where no image is available" do
      images_should_have "a" => [Image.new("a1", "a1")],
                         "b" => [] # No image


      @composer.generate("aba").should == [[Image.new("a1", "a1"), Image.new("a1", "a1")]]
    end
  end

  describe "(punctuation)" do
    Punctuation.list.each do |punctuation|
      it "should generate note for #{punctuation.symbol} character" do
        punctuation_image = Image.new(punctuation.name, punctuation.name)
        images_should_have punctuation.name => [punctuation_image]

        @composer.generate(punctuation.symbol).should == [[punctuation_image]]
      end
    end
  end

  describe "(multiple words)" do
    it "should generate note with multiple words" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")],
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]

      @composer.generate("a b c").should == [[Image.new("a1", "a1")], [Image.new("b1", "b1")], [Image.new("c1", "c1")]]
    end

    it "should generate note with multiple words" do
      images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                         "b" => [], # No images
                         "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]

      @composer.generate("a b c").should == [[Image.new("a1", "a1")], [Image.new("c1", "c1")]]
    end    
  end


  def images_should_have(expected_image_map)
    expected_image_map.each do |character, expected_results|
      @images.stub(:find_for).with(character).and_return(expected_results)
    end
  end

  RSpec::Matchers.define :be_note_with do |expected_elements|
    match do |actual_note|
      actual_note.elements == expected_elements
    end
  end

end
