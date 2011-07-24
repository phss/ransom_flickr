$:.unshift(File.dirname(__FILE__) + "/../../lib")
require "cucumber/rake/task"
require "rspec/core/rake_task"

desc "Run cucumber features"
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["--format", "s", "--color"] 
end

desc "Run all tests"
task :all_tests => [:cucumber, :spec]

task :default => :spec