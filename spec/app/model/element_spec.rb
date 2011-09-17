require File.dirname(__FILE__) + "/../../spec_helper"

describe Element do

  describe "(constructors)" do
    it "should construct note" do
      Element.note_with([1, 2, 3]).should == Element.new(:note, [1, 2, 3])
    end

    it "should construct word" do
      Element.word_with([1, 2, 3]).should == Element.new(:word, [1, 2, 3])
    end

    it "should construct space" do
      Element.space.should == Element.new(:space)
    end

    it "should construct line break" do
      Element.break.should == Element.new(:break)
    end
  end

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

    it "should be equal when types and position match" do
      Element.new(:blah).at(2).should == Element.new(:blah).at(2)
    end

    it "should not be equal when position don't match and types do match" do
      Element.new(:blah).at(2).should_not == Element.new(:blah).at(20)
    end
  end

end