require File.dirname(__FILE__) + "/../../spec_helper"

describe "Notes" do

  before do
    @mongo_collection = Mongo::Connection.new.db("notes-test").collection("notes")
    @mongo_collection.remove
    Notes.db_collection = nil
  end

  describe "(saving notes)" do
    it "should fail to save note if has no underyling DB collection" do
      expect { Notes.save("blah") }.to raise_error(StandardError, "No underlying DB collection")
    end  

    it "should save note" do
      Notes.db_collection = @mongo_collection

      Notes.save("some note text")

      @mongo_collection.find().should have_notes(["some note text"])
    end

  end

  RSpec::Matchers.define :have_notes do |expected_elements|
    match do |actual_elements|
      expected_elements.to_a.each do |expected|
        return false unless actual_elements.find { |actual| expected == actual["note"] }
      end
    end
  end

end