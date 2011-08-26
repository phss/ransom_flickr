require File.dirname(__FILE__) + "/../spec_helper"

describe FlickrImageService do

  before do
    @flickr_wrapper = double("Flickr Wrapper")
    @service = FlickrImageService.new(@flickr_wrapper)
  end

  it "should browse images from letter group for a given character" do
    expected_photo_urls = ["url1", "url2", "url3"]
    flickr_photos = expected_photo_urls.collect { |url| photo(url) }
    
    @flickr_wrapper.should_receive(:search).with("a", :group => "oneletter") { flickr_photos }

    @service.browse("a").should == expected_photo_urls
  end


  StubPhoto = Struct.new(:url_sq)

  def photo(url)
    StubPhoto.new(url)
  end

end