require 'sinatra'
require 'rubygems'

get '/research/?' do

  haml :research
end

get '/' do
  haml :index
end
