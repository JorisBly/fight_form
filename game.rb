require 'ruby2d'
require './map'
require './coin'
class Game
  WIDTH = 630
  HEIGHT = 480
  attr_accessor :player, :time_start, :map
  def initialize(map_filepath, tile_size: 30)
    @tile_size = tile_size
    @window = DSL.window
    @window.set title: "Fight Form"

    @window.set viewport_width: WIDTH
    @window.set viewport_height: HEIGHT
    @window.set borderless: false

    @time_start = Time.now
    @map = Map.new(map_filepath, @tile_size)
    @player = Player.new('Joris', 'media/player.png',
      x: @map.player[0], y: @map.player[1], width: @tile_size, height: @tile_size, z: 100, show: true
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
      @player.move_left(@tile_size, map.coins, map.tiles)
    elsif event.key == 'right'
      @player.move_right(@tile_size, map.coins, map.tiles)
    elsif event.key == 'up'
      @player.move_up(@tile_size, map.coins, map.tiles)
    elsif event.key == 'down'
      @player.move_down(@tile_size, map.coins, map.tiles)
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
