require 'mongoid'
Mongoid.load!("./config/mongoid.yaml", :development)
class Level
  include Mongoid::Document
  field :name, type: String
  field :wall, type: String
  field :ground, type: String
  field :coin, type: String
  field  :player, type: String
end