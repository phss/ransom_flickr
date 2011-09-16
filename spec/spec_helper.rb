require "rspec"
require "rack/test"
require File.dirname(__FILE__) + "/helpers/fake_image_service"
require File.dirname(__FILE__) + "/../lib/flickr"
require File.dirname(__FILE__) + "/../app/model"

ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end