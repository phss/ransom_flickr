require File.dirname(__FILE__) + "/../../spec_helper"

describe "Image" do

  it "should be constructed from DB hash" do
    image = Image.from_db("character" => "x", "image_url" => "some url", "image_id" => "blah123")

    image.character.should == "x"
    image.url.should == "some url"
    image.image_id.should == "blah123"
  end

  it "should add character to image" do
    image = Image.new("blah456", "another url").with_character("y")

    image.character.should == "y"
    image.url.should == "another url"
    image.image_id.should == "blah456"
  end

  describe "(equality)" do
    it "should be equal to another object with same image_id" do
      image1 = Image.new("id", "a", "a")
      image2 = Image.new("id", "b", "b")

      image1.should == image2
    end

    it "should be different to another object with different image_id" do
      image1 = Image.new("id1", "x", "x")
      image2 = Image.new("id2", "x", "x")

      image1.should_not == image2
    end
  end

end