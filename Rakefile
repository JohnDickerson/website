require 'rake'
require 'rubygems'

desc "Run the app in development mode"
task :rundev do
  shotgun config.ru
end

desc "Invokes HTTrack to rip site into static files"
task :statickify do
  #rackup -p 9292   # Boot up the site
  #httrack "http://127.0.0.1:9292/" -O "/Users/spook/code/website_backup" # Rip it
end
