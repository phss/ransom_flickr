require File.dirname(__FILE__) + "/../spec_helper"

describe "Pagination" do

  it "should generate link with pagination info with page number from params" do
    pagination_module_with_params(:service_page => 2).link_with_pagination("url").should == "url?service_page=2"
  end

  it "should generate link with pagination info with supplied page number" do
    pagination_module_with_params(:service_page => 2).link_with_pagination("url", 3).should == "url?service_page=3"
  end

  FakeModule = Struct.new(:params)

  def pagination_module_with_params(params)    
    pagination = FakeModule.new(params)
    pagination.extend(Pagination)
  end

end