require 'ruby2d'
require './map'
require './coin'
class Game
  attr_accessor :x_width, :y_height ,:time_start, :elapsed, :map, :player
  def initialize(x_width, y_height, player_name, level, tile_size)
    @player =  Player.new(
      player_name,
      WIDTH,
      HEIGHT,
      level['player'],
      x: 896,
      y: 512,
      width: tile_size,
      height: tile_size,
      z: 100,
      show: true
    )
    @level = level
    # @background = background
    @x_width = x_width
    @y_height = y_height
    @map_path = level['name']
    @tile_size = tile_size
  end

  def start
      self.time_start = Time.now
      @map = Map.new(@tile_size, @level )
      @player_points = Text.new("Pièces: #{@player.points}",
                                x: 120, y: 0, size: 64,
                                z: 10)
      @timer = Text.new("Time: #{self.elapsed}",
                        x: 500, y: 0, size: 64,
                        z: 200)
  end

  def update
    if @map.coins.length === 0
      self.end_game
    end
    @player_points.text = "Pièces: #{@player.points}"
    @timer.text = "Time: #{Time.at(self.elapsed).utc.strftime("%M:%S")}"
  end
  def elapsed
    Time.now - @time_start
  end

  def move(offset_x, offset_y)
    tiles = @map.tiles + @map.coins
    collision = tiles.select{ |item| item.x == offset_x && item.y == offset_y }
    case collision.length
    when 2
      collision[1].catched
      @map.coins.reject!{ |coin| coin.x === offset_x && coin.y === offset_y }
      @player.add_point
      @map.update_camera(@player.x - offset_x, @player.y - offset_y)
    when 1
      if collision[0].path.include?("terrain")
        @map.update_camera(@player.x - offset_x, @player.y - offset_y)
      end
    when nil
      @map.update_camera(@player.x - offset_x, @player.y - offset_y)
    end
  end

  def check_collision(obstacles, position_x, position_y)
    collision = false
    obstacles.each do |obstacle|
      collision = obstacle.collision(position_x, position_y)
      break if collision
    end
    collision
  end

  def close
    @player.remove
    @map.remove
    @timer.remove
    @player_points.remove
  end
  def end_game
    close
  end


end