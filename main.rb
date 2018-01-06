require 'rubygems'
require 'sinatra'
require 'mongoid'
require 'haml'

Mongoid.load!("mongoid.yml")

class RSVP
  include Mongoid::Document
  store_in collection: "rsvp", database: "wedding"

  field :first, type: String
  field :last, type: String
  field :result, type: String
  field :diet, type: String
end

class SongRequest
  include Mongoid::Document
  store_in collection: "SongRequests", database: "wedding"

  field :name, type: String
  field :artist, type: String
end

class WeddingApp < Sinatra::Base
  
  valid_actions = ["rsvp", "ceremony", "reception", "lodging", "faq", "registry"]
  
  get '/' do
    haml :index
  end
  
  post '/rsvp' do
    r = RSVP.new
    puts params.inspect
    r.first = params['first']
    r.last = params['last']
    r.result = params['RSVP']
    r.diet = params['diet']
    puts r.save!
    puts r.inspect
    redirect '/rsvp'
  end

  post '/song-request' do
    s = SongRequest.new
    s.name = params['name']
    s.artist = params['artist']
    puts s.save!
    redirect '/rsvp'
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
  
  run! if app_file == $0
  
end

class WeddingPrivate < Sinatra::Base
  
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == ['marnie', 'sardines']  
  end

  get '/' do
    haml :private
  end

  get '/rsvplist' do
    haml :rsvplist, locals: {coming: RSVP.where(result: "Yes"), not_coming: RSVP.where(result: "No")}
  end
  
  get '/songlist' do  
    haml :songlist, locals: {list: SongRequest.all}
  end
  
end
