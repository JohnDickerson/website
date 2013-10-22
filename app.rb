require 'sinatra'
require 'rubygems'

configure do

end

# List of research projects
get '/research/?' do  
  haml :research
end

# List of all publications
get '/pubs/?' do
  haml :publications
end

# Grab a {.pdf, .pptx} for a specific publication
get '/pubs/:title' do
  #send_file File.join(settings.public_folder, params[:title]+'.pdf')
end

# Home page (links to all the other main pages)
get '/' do
  haml :index
end
