require File.dirname(__FILE__) + "/../../spec_helper"

describe Element do

  describe "(equality)" do
    it "should be equal when there are no elements and types match" do
      Element.new(:blah).should == Element.new(:blah)
    end

    it "should not be equal when there are no elements and types don't match" do
      Element.new(:blah).should_not == Element.new(:not_blah)
    end

    it "should be equal when elements and types match" do
      Element.new(:blah, [1, 2, 3]).should == Element.new(:blah, [1, 2, 3])
    end

    it "should not be equal when elements don't match and types do match" do
      Element.new(:blah, [1, 2, 3]).should_not == Element.new(:blah, [4, 5])
    end
  end

end