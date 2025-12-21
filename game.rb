require 'ruby2d'
require './map'
require './coin'
class Game
  attr_accessor :time_start, :map
  def initialize(x_width, y_height, player)
    @player = player
    # @background = background
    @x_width = x_width
    @y_height = y_height
  end

  def start
    self.time_start = Time.now
    @map = Map.new('media/map_1.txt')
  end

  def update
    if @map.coins.length === 0
      self.end_game
    end
  end
  def elapsed
    Time.now - @time_start
  end

  def end_game
    close
  end
end
