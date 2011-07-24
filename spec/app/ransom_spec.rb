require File.dirname(__FILE__) + "/../spec_helper"
require File.dirname(__FILE__) + '/../../app/ransom'

set :environment, :test

describe "Ransom App" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "(admin authentication)" do
    it "should not allow admin access without credentials" do
      get "/admin"

      last_response.status.should == 401
    end

    it "should not allow admin access with bad credentials" do
      authorize "bad", "login"

      get "/admin"

      last_response.status.should == 401
    end

    it "should allow admin access with correct credentials" do
      authorize "admin", "Demo123"

      get "/admin"

      last_response.should be_ok
    end    
  end
end