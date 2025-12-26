require 'ruby2d'
require './player'
require './wall'
require './game'
require './database'

redis = Database.new(host: "localhost", port: 6379)

game = Game.new(ARGV[0] || 'media/map_1.txt')
game.start

redis.save_score(game.player)
