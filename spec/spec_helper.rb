require "rspec"
require "rack/test"
require File.dirname(__FILE__) + "/helpers/fake_image_service"

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end