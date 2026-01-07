require 'ruby2d'
require './map'
require './coin'
class Game
  attr_accessor :x_width, :y_height ,:time_start, :elapsed, :map, :player
  def initialize(x_width, y_height, player_name, map_path)
    @player =  Player.new(
      player_name,
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
    @x_width = x_width
    @y_height = y_height
    @map_path = map_path
  end

  def start
      self.time_start = Time.now
      @map = Map.new(@map_path, 30)
      @player_position = Text.new("x: #{@player.x} y: #{@player.y}")
      @player_points = Text.new("Points: #{@player.points}",
                                x: 120, y: 0,
                                z: 10)
      @timer = Text.new("Time: #{self.elapsed}",
                        x: 200, y: 0,
                        z: 200)
  end

  def update
    if @map.coins.length === 0
      self.end_game
    end
    @player_position.text = "x: #{@player.x} y: #{@player.y}"
    @player_points.text = "Points: #{@player.points}"
    @timer.text = "Time: #{Time.at(self.elapsed).utc.strftime("%M:%S")}"
  end
  def elapsed
    Time.now - @time_start
  end

  def close
    @player.remove
    @map.remove
    @timer.remove
    @player_position.remove
    @player_points.remove
  end
  def end_game
    close
  end
end
