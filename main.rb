require './db.rb'
require 'sinatra'
require 'mongoid'
require 'haml'

valid_actions = ["rsvp", "ceremony", "reception", "test"]

Mongoid.load!("mongoid.yml")

get '/' do
  haml :index
end

get '/*' do |action|
  if valid_actions.include?(action)
    status 200
    haml action.to_sym
  else
    status 404
    haml :err_404
  end
end

post '/rsvp' do
  r = RSVP.new
  r.first = params['first']
  r.last = params['last']
  r.result = params['RSVP']
  r.diet = params['diet']
  r.save!
end
