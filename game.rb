require 'ruby2d'
require './map'
require './coin'
class Game
  WIDTH = 630
  HEIGHT = 480
  attr_accessor :player, :time_start, :map
  def initialize(map_filepath)
    @window = DSL.window
    @window.set title: "Fight Form"

    @window.set viewport_width: WIDTH
    @window.set viewport_height: HEIGHT
    @window.set borderless: false

    @time_start = Time.now
    @map = Map.new(map_filepath)
    @player = Player.new('Joris', 'media/player.png',
      x: @map.player[0], y: @map.player[1], width: 30, height: 30, z: 100, show: true
    )

    @player_position = Text.new("x: #{@player.x} y: #{@player.y}")
    @player_points = Text.new("Points: #{@player.points}", x: 120, y: 0, z: 10)
    @timer = Text.new("Time: #{elapsed}", x: 200, y: 0, z: 200)

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
    @player_position.text = "x: #{@player.x} y: #{@player.y}"
    @player_points.text = "Points: #{@player.points}"
    @timer.text = "Time: #{Time.at(elapsed).utc.strftime("%M:%S")}"
    end_game if @map.coins.empty? || elapsed > 60
  end

  def elapsed
    Time.now - @time_start
  end

  def end_game
    @window.close
  end
end
