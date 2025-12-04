require 'ruby2d'
class Game
  attr_accessor :x_width, :y_height , :coins
  def initialize(x_width, y_height, player, background)
    @player = player
    @background = background
    @x_width = x_width
    @y_height = y_height
    @coins = []
  end

  def start()
    for i in 1..10
      @coins.push(Collectible.new('media/coin.png', x: rand(WIDTH), y: rand(HEIGHT), width: 32, height: 32))
    end
  end

  def update()
    puts "Game updated"
  end
end
