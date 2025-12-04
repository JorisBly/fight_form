class Player < Sprite
  attr_accessor :name, :max_width ,:max_height, :points

  def initialize( max_width, max_height, path, **args)
    super(path, **args)
    @max_width = max_width
    @max_height = max_height
    @points = 0
    puts "Joueur initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def move(x_speed, y_speed, coins)
    if (self.x + x_speed ) > 0 && (self.x + x_speed) < self.max_width
      self.x += x_speed
      end
    if (self.y + y_speed) > 0 && (self.y + y_speed) < (self.max_height - 30)
      self.y += y_speed
    end
    self.catch_coin(coins)
    end
  def move_right
    self.x += 2
  end
  def move_left
    self.x += -2
  end

  def move_up
    self.y += -2
  end

  def move_down
    self.y += 2
  end

  def add_point(point = 1)
    @points += point
  end
  def get_points
    @points
  end

  def catch_coin(coins)
    coins.each do |coin|
      if (coin.x - self.x).abs <= 10 && (coin.y - self.y).abs <= 10
        coin.destroy
        self.add_point
      end
      end
    end
end
