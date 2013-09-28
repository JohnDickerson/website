require 'sinatra'
require 'rubygems'

configure do

end

get '/research/?' do
  
  haml :research
end

get '/' do
  haml :index
end
