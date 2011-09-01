require File.dirname(__FILE__) + "/../spec_helper"

describe FlickrImageService do

  before do
    @flickr_wrapper = double("Flickr Wrapper")
    @service = FlickrImageService.new(@flickr_wrapper)
  end

  it "should browse images from letter group for a given character" do
    flickr_photos = [ photo("id1", "url1"), photo("id2", "url2"), photo("id3", "url3")]

    @flickr_wrapper.should_receive(:search).with(:tag => "a", :group => "One Letter", :page => 1) { flickr_photos }

    @service.browse("a").should == [ Image.new("id1", "url1", "a"), 
                                     Image.new("id2", "url2", "a"), 
                                     Image.new("id3", "url3", "a") ]
  end

  it "should browse images from a given page" do
    flickr_photos = [ photo("id", "url") ]

    @flickr_wrapper.should_receive(:search).with(:tag => "a", :group => "One Letter", :page => 42) { flickr_photos }

    @service.browse("a", 42).should == [ Image.new("id", "url", "a") ]
  end

  it "should fetch image for given id" do
    @flickr_wrapper.should_receive(:fetch_url).with("imageid") { "some url" }

    @service.find_image("imageid").should match_all_attributes_of(Image.new("imageid", "some url"))
  end

  StubPhoto = Struct.new(:id, :url_sq)

  def photo(id, url)
    StubPhoto.new(id, url)
  end

  RSpec::Matchers.define :match_all_attributes_of do |expected|
    match do |actual|
      expected.image_id == actual.image_id && expected.url == actual.url && expected.character == actual.character
    end
  end

end