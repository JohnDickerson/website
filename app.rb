require 'sinatra'
require 'rubygems'

configure do

end

get '/research/?' do  
  haml :research
end

get '/publications/?' do
  haml :publications
end

get '/' do
  haml :index
end
