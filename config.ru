require 'rubygems'
require 'sinatra'
require 'bundler'
require 'set'
require 'citeproc'

Bundler.require
$ROOT = File.expand_path("../", __FILE__)

# Load all helpers and routes
Dir.glob(File.dirname(__FILE__) + '/helpers/*.rb') {|f| load f}
Dir.glob(File.dirname(__FILE__) + '/routes/*.rb') {|f| load f}

if $bib.nil? or $bib_short.nil?
   puts "Reading from bibliography file; this may take a while ..."
   # Convert .bib file to a Ruby data structure, long version
   $bib = BibTeX.open('public/files/dickerson.bib')
   $bib.each do |obj|
     obj.replace($bib.q('@string'))
   end

   # Convert .bib file to a Ruby data structure, long version
   $bib_short = BibTeX.open('public/files/dickerson.bib')
   $short_names = BibTeX.open('public/files/short_names.bib')
   $bib_short.each do |obj|
     obj.replace($short_names.q('@string'))
   end

   # Styles that look okay:
   # :mla
   # :apa
   # 'https://github.com/citation-style-language/styles/raw/master/chicago-author-date.csl'
   # 'https://github.com/citation-style-language/styles/raw/master/acm-sig-proceedings-long-author-list.csl'
   $bib_citestyle = \
'https://github.com/citation-style-language/styles/raw/master/acm-sig-proceedings-long-author-list.csl'	

   puts "Finished translating .bib to string hash"

else
   puts "Already loaded .bib files"
end


require "#{$ROOT}/app.rb"

run Sinatra::Application
