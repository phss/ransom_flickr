require File.dirname(__FILE__) + "/../../spec_helper"

describe "Image" do

  it "should be constructed from DB hash" do
    image = Image.from_db("character" => "x", "image_url" => "some url", "image_id" => "blah123")

    image.character.should == "x"
    image.url.should == "some url"
    image.image_id.should == "blah123"
  end

end