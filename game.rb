require 'ruby2d'
require './map'
require './coin'
class Game
  attr_accessor :player
  def initialize(map_filepath, tile_size: 30)
    @tile_size = tile_size
    @window = DSL.window
    @window.set title: "Fight Form"

    @time_start = Time.now
    @map = Map.new(map_filepath, @tile_size)
    @player = Player.new('Joris', 'media/player.png',
      x: @map.player[0], y: @map.player[1], width: @tile_size, height: @tile_size, z: 100, show: true
    )

    @window.set width: @map.width
    @window.set height: @map.height
    @window.set borderless: false

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
      @player.move(-@tile_size, 0, @map)
    elsif event.key == 'right'
      @player.move(+@tile_size, 0, @map)
    elsif event.key == 'up'
      @player.move(0, -@tile_size, @map)
    elsif event.key == 'down'
      @player.move(0, +@tile_size, @map)
    end
  end

  def update
    @player_position.text = "x: #{@player.x} y: #{@player.y}"
    @player_points.text = "Points: #{@player.points}"
    @timer.text = "Time: #{Time.at(elapsed).utc.strftime("%M:%S")}"
    end_game if @map.everything_collected? || elapsed > 60
  end

  def elapsed
    Time.now - @time_start
  end

  def end_game
    @window.close
  end
end
