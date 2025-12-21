require 'ruby2d'
require './player'
require './wall'
require './game'
require './database'

redis = Database.new(host: "localhost", port: 6379)

game = Game.new
game.start

redis.save_score(game.player)
