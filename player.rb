class Player < Sprite
  attr_reader :points

  def initialize(name, max_width, max_height, path, **args)
    @name = name
    super(path, **args)
    @max_width = max_width
    @max_height = max_height
    @points = 0
    puts "Joueur initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def move_right(movement, coins, obstacles)
    unless check_collision(obstacles, @x + movement, @y)
      self.x += movement
    end
    catch_coin(coins)
  end
  def move_left(movement,coins, obstacles)
    unless check_collision(obstacles, @x - movement, @y)
      self.x += -movement
    end
    catch_coin(coins)
  end

  def move_up(movement,coins, obstacles)
    unless check_collision(obstacles, @x, @y - movement)
      self.y += -movement
    end
    catch_coin(coins)
  end

  def move_down(movement, coins, obstacles)
    unless check_collision(obstacles, @x, @y + movement)
      self.y += movement
    end
    catch_coin(coins)
  end

  def add_point(point = 1)
    @points += point
  end
  def get_points
    @points
  end

  def catch_coin(coins)
    catched = false
    coins.each do |coin|
      puts "xcoin : #{coin.x} ycoin : #{coin.y} | player : #{x} #{y}"
      catched = coin.catched(@x, @y)
      add_point
      break if catched
    end
  end

  def check_collision(obstacles, position_x, position_y)
    collision = false
    obstacles.each do |obstacle|
      collision = obstacle.collision(position_x, position_y)
      obstacle.play_sound
      break if collision
    end
    collision
  end
end
