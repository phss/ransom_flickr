require File.dirname(__FILE__) + "/../../spec_helper"

describe "NoteRepository" do

  before do
    @mongo_collection = Mongo::Connection.new.db("notes-test").collection("notes")
    @mongo_collection.remove
    @generator = double("Key Generator")
    @notes = NoteRepository.new(@mongo_collection, @generator)
  end

  it "should save note with generated key" do
    @generator.should_receive(:next).and_return("abc123")

    @notes.save("some note text")

    @mongo_collection.find().should have_notes([{"key" => "abc123", "note" => "some note text"}])
  end

  it "should return nil when finding note for inexisting key" do
    @notes.find_by_key("no such key").should be_nil
  end

  it "should return nil when finding note for inexisting key" do
    @generator.should_receive(:next).and_return("ky123")
    @notes.save("text")    

    @notes.find_by_key("ky123")["note"].should == "text"
  end

  RSpec::Matchers.define :have_notes do |expected_elements|
    match do |actual_elements|
      expected_elements.to_a.each do |expected|
        return false unless actual_elements.find { |actual| expected["note"] == actual["note"] && expected["key"] == actual["key"]}
      end
    end
  end

end