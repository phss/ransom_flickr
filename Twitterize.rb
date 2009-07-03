require 'rubygems'
require 'open-uri'
require 'json'
require 'cgi'

class Twitterize
	
	#temporary solution as, by now, we only need text excerpts
	def self.search(query)
		query = CGI.escape(query)
	JSON.parse(
		open("http://search.twitter.com/search.json?q=#{query}").read		
	)['results'].collect{|s| s['text']}
	end
	
end


