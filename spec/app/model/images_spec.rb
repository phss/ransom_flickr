require File.dirname(__FILE__) + "/../../spec_helper"

describe "Images" do

  before do
    @mongo_collection = Mongo::Connection.new.db("images-test").collection("images")
    @mongo_collection.remove
    Images.db_collection = nil
  end

  describe "(saving images)" do
    it "should fail to save image if has no underyling DB collection" do
      expect { Images.save("a", FlickrImage.new("id", "url")) }.to raise_error(StandardError, "No underlying DB collection")
    end  

    it "should save image" do
      Images.db_collection = @mongo_collection

      Images.save("x", FlickrImage.new("some id", "some url"))

      @mongo_collection.find().should have_elements([{"character" => "x", "image_id" => "some id", "image_url" => "some url"}])
    end
  end

  describe "(finding images)" do
    it "should fail to find images if has no underyling DB collection" do
      expect { Images.find_for("a") }.to raise_error(StandardError, "No underlying DB collection")
    end

    it "should return no images if db empty" do
      Images.db_collection = @mongo_collection

      Images.find_for("a").should be_empty
    end

    it "should return images for search character" do      
      image_a_1 = FlickrImage.new("a1", "some url a1")
      image_a_2 = FlickrImage.new("a2", "some url a2")
      image_b_1 = FlickrImage.new("b1", "some url b1")

      Images.db_collection = @mongo_collection
      Images.save("a", image_a_1)
      Images.save("a", image_a_2)
      Images.save("b", image_b_1)

      Images.find_for("a").should have_elements([{"character" => "a", "image_id" => "a1", "image_url" => "some url a1"},
                                                 {"character" => "a", "image_id" => "a2", "image_url" => "some url a2"}])
    end
  end

  RSpec::Matchers.define :have_elements do |expected_elements|
    match do |actual_elements|
      actual_elements.to_a.each do |actual|
        return false unless expected_elements.find { |expected|  expected["character"] == actual["character"] && 
                                                                 expected["image_id"] == actual["image_id"] && 
                                                                 expected["image_url"] == actual["image_url"] }
      end
    end
  end
end