require 'rubygems'
require 'sinatra'
require "haml"
require "sass"
require "sequel"
require 'ransom_flickr'
require 'Twitterize'

configure do
	DB = Sequel.sqlite
	DB.create_table :notes do # TODO persist on a real DB
		primary_key :id
		String :link
		String :text
	end

	RF = RansomFlickr.new("flickr_key.yaml")
	puts "Preloading images"
  RF.preload
	puts "Finished preloading"	
end

get "/" do
  haml :new
end

get "/list" do
	notes = DB[:notes].collect { |note| note[:text] }
	"Blah: #{DB[:notes].count.to_s}<br/>#{notes}"
end

post '/generate' do
  @note = params[:note]
  puts @note
  @photo_urls = RF.get_photo_urls(@note)
  puts @photo_urls  
  haml :generate
end

post '/save' do
	@link = "something" # TODO generate a link
	DB[:notes].insert(:link => @link, :text => params[:note])
	haml :saved
end

get '/view/:link' do
  note = DB[:notes].filter(:link => params[:link]).first[:text]
	@photo_urls = RF.get_photo_urls(note)
  haml :view
end

get '/ransom_flickr.css' do
   content_type 'text/css', :charset => 'utf-8'
   sass :ransom_flickr
end
