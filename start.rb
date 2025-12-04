require 'ruby2d'
require './player'
require './collectible'
require './game'

set title: "Fight Form"
WIDTH = 620
HEIGHT = 460

@player = Player.new(
  WIDTH,
  HEIGHT,
  'media/player.png',
  x: 10,
  y: 10,
  width: 40,
  height: 40,
  z: 100,
  show: true
)

@game = Game.new(WIDTH, HEIGHT, @player, Image.new('media/sky.jpg', width: WIDTH, height: HEIGHT))

set viewport_width: WIDTH
set viewport_height: HEIGHT
set borderless: false

@game.start
@player_position = Text.new("x: #{@player.x} y: #{@player.y}")
@player_points = Text.new("Points: #{@player.points}",
                          x: 100, y: 0,
                          z: 10)
@x_speed = 0
@y_speed = 0

on :key_down do |event|
  if event.key == 'left'
    @x_speed = -2
    @y_speed = 0
  elsif event.key == 'right'
    @x_speed = 2
    @y_speed = 0
  elsif event.key == 'up'
    @x_speed = 0
    @y_speed = -2
  elsif event.key == 'down'
    @x_speed = 0
    @y_speed = 2
  end
end

update do
  @player.move(@x_speed, @y_speed, @game.coins)
  @player_position.text = "x: #{@player.x} y: #{@player.y}"
  @player_points.text = "Points: #{@player.points}"
end

show