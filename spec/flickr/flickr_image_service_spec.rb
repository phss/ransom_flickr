require File.dirname(__FILE__) + "/../spec_helper"

describe FlickrImageService do

  before do
    @flickr_wrapper = double("Flickr Wrapper")
    @service = FlickrImageService.new(@flickr_wrapper)
  end

  it "should browse images from letter group for a given character" do
    flickr_photos = [ photo("id1", "url1"), photo("id2", "url2"), photo("id3", "url3")]

    @flickr_wrapper.should_receive(:search).with(:tag => "a", :group => "One Letter") { flickr_photos }

    @service.browse("a").should == [ Image.new("id1", "url1", "a"), 
                                     Image.new("id2", "url2", "a"), 
                                     Image.new("id3", "url3", "a") ]
  end


  StubPhoto = Struct.new(:id, :url_sq)

  def photo(id, url)
    StubPhoto.new(id, url)
  end

end