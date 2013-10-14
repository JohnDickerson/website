require 'sinatra'
require 'rubygems'

configure do

end

# List of research projects
get '/research/?' do  
  haml :research
end

# List of all publications
get '/publications/?' do
  haml :publications
end

# Eventually, auto-generate individual pages per publication
get '/publication/:title' do
  haml :publications
end

# Home page (links to all the other main pages)
get '/' do
  haml :index
end
