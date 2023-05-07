require 'sinatra'
require 'rubygems'
require_relative 'helpers/bib_helpers.rb'

configure do

end

before do
  # Have to explicitly activate the navbar links
  @active = :none
end

# List of research projects
get '/research/?' do
  @subtitle = "Research"
  @active = :research
  haml :research
end

# List of all publications
get '/pubs/?' do
  @subtitle = "Publications"
  @active = :publications
  haml :publications
end

# Grab a {.pdf, .pptx} for a specific publication
get '/pubs/:title' do
  #send_file File.join(settings.public_folder, params[:title]+'.pdf')
end

# Lists side projects (similar to research page)
get '/industry/?' do
  @subtitle = "Industry Experience"
  @active = :industry
  haml :industry
end

# Lists side projects (similar to research page)
get '/lab/?' do
  @subtitle = "Dickerson Lab"
  @active = :lab
  haml :lab
end

# Lists side projects (similar to research page)
get '/side_projects/?' do
  @subtitle = "Side Projects"
  @active = :side_projects
  haml :side_projects
end

# Service (academic, otherwise)
get '/service/?' do
  @subtitle = "Service"
  @active = :service
  haml :service
end

# Home page (links to all the other main pages)
get '/' do
  haml :index
end
