class Player < Sprite
  attr_reader :name, :points

  def initialize(name, path, **args)
    super(path, **args)
    @name = name
    @points = 0
    puts "Joueur initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def move(delta_x, delta_y, map)
    case tile = map.tiles.find { |tile| tile.x == @x + delta_x && tile.y == @y + delta_y }
    when Wall
      tile.play_sound
    when Coin
      tile.play_sound
      tile.remove
      map.tiles.delete(tile)
      add_point
      @x += delta_x
      @y += delta_y
    else
      @x += delta_x
      @y += delta_y
    end
  end

  def add_point(point = 1)
    @points += point
  end
end
