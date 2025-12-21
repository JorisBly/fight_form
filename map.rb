class Map
  attr_reader :tiles ,:coins, :player
  def initialize(file_path, tile_size)
    @tiles = []
    @coins = []
    @tile_size = tile_size
    load_map(file_path)
  end

  def load_map(path)
    File.readlines(path).each_with_index do |line, row|
      line.chomp.chars.each_with_index do |char, col|
        x = col * @tile_size
        y = row * @tile_size

        case char
        when '#'
          @tiles << Wall.new('media/block_idle.svg', 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when '.'
          @tiles << Wall.new('media/terrain_stone_vertical_middle.svg', 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when 'x'
          @tiles << Wall.new('media/block_rest.svg', 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when '"'
          @tiles << Wall.new('media/grass.png', 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
        when 'c'
          @tiles << Wall.new('media/terrain_stone_vertical_middle.svg', 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
          @coins << Coin.new('media/coin.png', 'media/sfx_coin.ogg', x: x, y: y, width: @tile_size, height: @tile_size, z: 100)
        when 'p'
          @tiles << Wall.new('media/terrain_stone_vertical_middle.svg', 'media/sfx_coin.ogg' , x: x, y: y, width: @tile_size, height: @tile_size)
          @player = [x, y]
        end
      end
    end
  end

  # def generate_coins
  #   if @coins.length < 30
  #     if rand(100) < 10
  #       @coins.push(Coin.new('media/coin.png', 'media/sfx_coin.ogg', x: rand(WIDTH - TILE), y: rand(HEIGHT - TILE), width: TILE, height: TILE, z: 100))
  #     end
  #     end
  #     end
end
