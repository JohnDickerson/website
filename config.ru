require 'rubygems'
require 'sinatra'
require 'bundler'
require 'set'

Bundler.require
$ROOT = File.expand_path("../", __FILE__)

Dir.glob(File.dirname(__FILE__) + '/helpers/*.rb') {|f| load f}
Dir.glob(File.dirname(__FILE__) + '/routes/*.rb') {|f| load f}

require "#{$ROOT}/app.rb"

run Sinatra::Application
