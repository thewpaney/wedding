require 'mongoid'

class RSVP
  include Mongoid::Document
  store_in collection: "RSVP", database: "wedding"

  field :first, type: String
  field :last, type: String
  field :result, type: String
  field :diet, type: String
end
