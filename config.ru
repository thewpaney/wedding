require 'rubygems'
require 'sinatra'

require File.expand_path '../main.rb', __FILE__

run Rack::URLMap.new({"/" => WeddingApp, "/private" => WeddingPrivate})
