require 'mongoid'
Mongoid.load!("./config/mongoid.yaml", :development)
class Level
  include Mongoid::Document
  field :name, type: String
  field :wall, type: String
  field :ground, type: String
  field :coin, type: String
  field  :player, type: String

  def  self.get_map(level_name)
    self.where(name: /#{level_name}/i).first.to_json
  end

end