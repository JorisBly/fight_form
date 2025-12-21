class Player < Sprite
  attr_reader :name, :points

  def initialize(name, path, **args)
    super(path, **args)
    @name = name
    @points = 0
    puts "Joueur initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def move_right(movement, coins, obstacles)
    self.x += movement unless check_collision(obstacles, @x + movement, @y)
    catch_coin(coins)
  end
  def move_left(movement,coins, obstacles)
    self.x += -movement unless check_collision(obstacles, @x - movement, @y)
    catch_coin(coins)
  end

  def move_up(movement,coins, obstacles)
    self.y += -movement unless check_collision(obstacles, @x, @y - movement)
    catch_coin(coins)
  end

  def move_down(movement, coins, obstacles)
    self.y += movement unless check_collision(obstacles, @x, @y + movement)
    catch_coin(coins)
  end

  def add_point(point = 1)
    @points += point
  end

  def catch_coin(coins)
    add_point if coins.find do |coin|
      puts "xcoin : #{coin.x} ycoin : #{coin.y} | player : #{x} #{y}"
      coin.catched(@x, @y)
    end
  end

  def check_collision(obstacles, position_x, position_y)
    obstacles.find do |obstacle|
      obstacle.play_sound
      obstacle.collision(position_x, position_y)
    end
  end
end
