class Map
  attr_accessor :tiles ,:coins
  def initialize(tile_size, level)
    @tiles = []
    @coins = []
    @tile_size = tile_size
    @level = level
    load_map
  end

  def load_map
    File.readlines(@level['name']).each_with_index do |line, row|
      line.chomp.chars.each_with_index do |char, col|
        x = col * @tile_size
        y = row * @tile_size

        case char
        when '#'
          @tiles << Wall.new(@level['border'], 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when '.'
          @tiles << Wall.new(@level['ground'], 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when 'x'
          @tiles << Wall.new(@level['platform'], 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when 'c'
          @tiles << Wall.new(@level['ground'], 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
          @coins << Coin.new(@level['coin'], 'media/sfx_coin.ogg', x: x, y: y, width: @tile_size, height: @tile_size, z: 100)
        end
      end
    end
  end

  def update_camera(offset_x, offset_y)
    @tiles.each do |tile|
      tile.x += offset_x
      tile.y += offset_y
    end

    @coins.each do |coin|
      coin.x += offset_x
      coin.y += offset_y
    end
  end

  def remove()
    @coins.each do |coin|
      coin.remove
    end
    @tiles.each do |tile|
      tile.remove
    end
  end
end
