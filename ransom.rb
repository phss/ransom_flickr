require 'rubygems'
require "ransom_flickr"
require 'sinatra'
require "haml"
require "sass"
require "sequel"

configure do
#	DB = Sequel.sqlite
#	DB.create_table :blah do
#		primary_key :id
#		String :name
#		Float :number
#	end
	RF = RansomFlickr.new("flickr_key.yaml")
	puts "Preloading images"
	RF.preload
	puts "Finished preloading"	
end

get "/" do
  haml :new
end

#get "/addblah" do
#	DB[:blah].insert(:name => "weee", :number => 42)
#end

#get "/blah" do
#	DB[:blah].insert(:name => "weee", :number => 42)
#	"Blah: #{DB[:blah].count.to_s}"
#end

post '/view' do
  # message = "Ransom is the practice of holding a prisoner to extort money or property to secure their release, or it can refer to the sum of money involved."
  message = params[:note]
  @photo_urls = RF.get_photo_urls(message)
  haml :view
end

get '/ransom_flickr.css' do
   content_type 'text/css', :charset => 'utf-8'
   sass :ransom_flickr
end
