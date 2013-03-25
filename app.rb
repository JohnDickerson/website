require 'sinatra'
require 'rubygems'


get '/' do
  haml :index
end
