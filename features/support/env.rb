# Stolen from https://github.com/cucumber/cucumber/blob/master/examples/sinatra/features/support/env.rb
require File.dirname(__FILE__) + '/../../app/ransom'

begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'rack/test'
require 'capybara/cucumber'

Capybara.app = Sinatra::Application