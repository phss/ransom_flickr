require File.dirname(__FILE__) + "/../../spec_helper"

describe "Notes" do

  before do
    @mongo_collection = Mongo::Connection.new.db("notes-test").collection("notes")
    @mongo_collection.remove
    @generator = double("Key Generator")
    Notes.db_collection = nil
    Notes.key_generator = nil
  end

  describe "(saving notes)" do
    it "should fail to save note if has no underyling DB collection" do
      Notes.key_generator = @generator
      expect { Notes.save("blah") }.to raise_error(StandardError, "No underlying DB collection")
    end  

    it "should fail to save note if has no key generator" do
      Notes.db_collection = @mongo_collection
      expect { Notes.save("blah") }.to raise_error(StandardError, "No key generator")
    end  

    it "should save note with generated key" do
      Notes.db_collection = @mongo_collection
      Notes.key_generator = @generator
      @generator.should_receive(:next).and_return("abc123")

      Notes.save("some note text")

      @mongo_collection.find().should have_notes([{"key" => "abc123", "note" => "some note text"}])
    end

  end

  RSpec::Matchers.define :have_notes do |expected_elements|
    match do |actual_elements|
      expected_elements.to_a.each do |expected|
        return false unless actual_elements.find { |actual| expected["note"] == actual["note"] && expected["key"] == actual["key"]}
      end
    end
  end

end