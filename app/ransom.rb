require "rubygems"
require "sinatra"
require "haml"

helpers do

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Access Denied\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'Demo123']
  end

end


get "/" do
 haml :homepage
end

get "/admin" do
  protected!
  "Admin"
end

get "/ransom.css" do
   content_type "text/css", :charset => "utf-8"
   sass :ransom
end