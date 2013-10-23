require 'sinatra'
require 'rubygems'

configure do

end

# List of research projects
get '/research/?' do
  @subtitle = "Research"
  haml :research
end

# List of all publications
get '/pubs/?' do
  @subtitle = "Publications"
  haml :publications
end

# Grab a {.pdf, .pptx} for a specific publication
get '/pubs/:title' do
  #send_file File.join(settings.public_folder, params[:title]+'.pdf')
end

# Lists side projects (similar to research page)
get '/side_projects/?' do
  @subtitle = "Side Projects"
  haml :side_projects
end

# Home page (links to all the other main pages)
get '/' do
  haml :index
end
