require File.dirname(__FILE__) + "/../../spec_helper"

describe Composer do

  before do
    @images = double("Flickr Wrapper")
    @composer = Composer.new(@images)
  end

  it "should generate note with first image of each character" do
    images_should_have "a" => [Image.new("a1", "a1"), Image.new("a2", "a2")],
                       "b" => [Image.new("b1", "b1"), Image.new("b2", "b2")],
                       "c" => [Image.new("c1", "c1"), Image.new("c2", "c2")]

    @composer.generate("abc") == [Image.new("a1", "a1"), Image.new("b1", "b1"), Image.new("c1", "c1")]
  end

  it "should generate note ignoring case" do
    images_should_have "a" => [Image.new("a1", "a1")]

    @composer.generate("aA") == [Image.new("a1", "a1"), Image.new("a1", "a1")]
  end


  def images_should_have(expected_image_map)
    expected_image_map.each do |character, expected_results|
      @images.stub(:find_for).with(character).and_return(expected_results)
    end
  end

end
