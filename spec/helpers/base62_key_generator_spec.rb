require File.dirname(__FILE__) + "/../spec_helper"

describe Base62KeyGenerator do

  before do
    @mongo_collection = Mongo::Connection.new.db("gen-test").collection("sequence")
  end

  it "should generate next key from sequence" do
    @mongo_collection.save({"_id" => "cat1", "next" => 5})

    generator = Base62KeyGenerator.new(@mongo_collection, "cat1", 1203010)

    generator.next.should == "52xT"
    generator.next.should == "52xU"
    generator.next.should == "52xV"
  end

end