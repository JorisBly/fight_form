require 'ruby2d'
require './player'
require './wall'
require './game'
require './database'

redis = Database.new(host: "localhost", port: 6379)

set title: "Fight Form"
WIDTH = 630
HEIGHT = 480

@player = Player.new(
  'Joris',
  WIDTH,
  HEIGHT,
  'media/player.png',
  x: 30,
  y: 30,
  width: 30,
  height: 30,
  z: 100,
  show: true
)

@game = Game.new(WIDTH, HEIGHT, @player)

set viewport_width: WIDTH
set viewport_height: HEIGHT
set borderless: false

@game.start
@player_position = Text.new("x: #{@player.x} y: #{@player.y}")
@player_points = Text.new("Points: #{@player.points}",
                          x: 120, y: 0,
                          z: 10)
@timer = Text.new("Time: #{@game.elapsed}",
                  x: 200, y: 0,
                  z: 200)

@x_speed = 0
@y_speed = 0

on :key_down do |event|
  if event.key == 'left'
    @player.move_left(30,@game.map.coins, @game.map.tiles)
  elsif event.key == 'right'
    @player.move_right(30,@game.map.coins, @game.map.tiles)
  elsif event.key == 'up'
    @player.move_up(30, @game.map.coins, @game.map.tiles)
  elsif event.key == 'down'
    @player.move_down(30,@game.map.coins, @game.map.tiles)
  end
end

update do
  # @player.move(@x_speed, @y_speed, @game.coins, @game.map.tiles)
  @player_position.text = "x: #{@player.x} y: #{@player.y}"
  @player_points.text = "Points: #{@player.points}"
  @timer.text = "Time: #{Time.at(@game.elapsed).utc.strftime("%M:%S")}"
  @game.update
  if Time.now - @game.time_start > 60
   close
   redis.save_score(@player)
  end
end

show