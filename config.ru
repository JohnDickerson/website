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

$bib_citestyle = :mla



require "#{$ROOT}/app.rb"

run Sinatra::Application
