require File.dirname(__FILE__) + "/../../spec_helper"

describe "Images" do

  before do
    @mongo_collection = Mongo::Connection.new.db("images-test").collection("images")
    @mongo_collection.remove
    @images = ImageRepository.new(@mongo_collection)
  end

  describe "(saving images)" do
    it "should fail if image doesn't have a character" do
      expect { @images.save(Image.new("id", "url")) }.to raise_error(StandardError, "Missing character")
    end

    it "should save image" do
      @images.save(Image.new("some id", "some url", "x"))

      @mongo_collection.find().should have_elements([{"character" => "x", "image_id" => "some id", "image_url" => "some url"}])
    end
  end

  describe "(removing images)" do
  
    it "should fail if image doesn't have a character" do
      expect { @images.remove(Image.new("id", "url")) }.to raise_error(StandardError, "Missing character")
    end

    it "should remove image" do
      saved_image = Image.new("some id", "some url", "x")      
      @images.save(saved_image)

      @images.remove(saved_image)

      @mongo_collection.find().has_next?.should be_false    
    end
  end

  describe "(finding images)" do
    it "should return no images if db empty" do
      @images.find_for("a").should be_empty
    end

    it "should return images for search character" do      
      image_a_1 = Image.new("a1", "some url a1", "a")
      image_a_2 = Image.new("a2", "some url a2", "a")
      image_b_1 = Image.new("b1", "some url b1", "b")

      @images.save(image_a_1)
      @images.save(image_a_2)
      @images.save(image_b_1)

      @images.find_for("a").should =~ [image_a_1, image_a_2]
    end
  end

  describe "(previously saved images)" do
    it "should verify image is not already saved" do
      @images.saved?(Image.new("a1", "some url a1", "a")).should == false
    end

    it "should verify image is already saved" do
      image = Image.new("a1", "some url a1", "a")      
      @images.save(image)

      @images.saved?(image).should == true
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