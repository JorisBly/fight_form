require 'ruby2d'
require './map'
require './coin'
class Game
  WIDTH = 630
  HEIGHT = 480
  attr_accessor :player, :time_start, :map
  def initialize
    @window = DSL.window
    @window.set title: "Fight Form"

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

    # @background = background
    @x_width = WIDTH
    @y_height = HEIGHT

    @window.set viewport_width: WIDTH
    @window.set viewport_height: HEIGHT
    @window.set borderless: false

    @time_start = Time.now
    @map = Map.new('media/map_1.txt')

    @player_position = Text.new("x: #{@player.x} y: #{@player.y}")
    @player_points = Text.new("Points: #{@player.points}", x: 120, y: 0, z: 10)
    @timer = Text.new("Time: #{elapsed}", x: 200, y: 0, z: 200)

    @x_speed = 0
    @y_speed = 0

    @window.on(:key_down) { |event| on_key_down(event) }
    @window.update { update }
  end

  def start
    @window.show
  end

  protected

  def on_key_down(event)
    if event.key == 'left'
      @player.move_left(30,map.coins, map.tiles)
    elsif event.key == 'right'
      @player.move_right(30,map.coins, map.tiles)
    elsif event.key == 'up'
      @player.move_up(30, map.coins, map.tiles)
    elsif event.key == 'down'
      @player.move_down(30,map.coins, map.tiles)
    end
  end

  def update
    # @player.move(@x_speed, @y_speed, coins, map.tiles)
    @player_position.text = "x: #{@player.x} y: #{@player.y}"
    @player_points.text = "Points: #{@player.points}"
    @timer.text = "Time: #{Time.at(elapsed).utc.strftime("%M:%S")}"
    end_game if @map.coins.empty?
    if Time.now - time_start > 60
      @window.close
    end
  end

  def elapsed
    Time.now - @time_start
  end

  def end_game
    @window.close
  end
end
