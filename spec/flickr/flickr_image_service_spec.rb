require File.dirname(__FILE__) + "/../spec_helper"

describe FlickrImageService do

  StubPhoto = Struct.new(:url_sq)

  before do
    @flickr_wrapper = double("Flickr Wrapper")
    @service = FlickrImageService.new(@flickr_wrapper)
  end

  it "should browse images from letter group for a given character" do
    @flickr_wrapper.should_receive(:search).with("a", :group => "oneletter") { [ StubPhoto.new("url1"), StubPhoto.new("url2"), StubPhoto.new("url3") ] }

    @service.browse("a").should == ["url1", "url2", "url3"]
  end

end