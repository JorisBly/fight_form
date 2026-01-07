class Player < Sprite
  attr_accessor :name, :max_width ,:max_height, :points

  def initialize(name, max_width, max_height, path, **args)
    @name = name
    super(path, **args)
    @max_width = max_width
    @max_height = max_height
    @points = 0
    puts "Joueur initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def add_point(point = 1)
    @points += point
  end
  def get_points
    @points
  end


  def check_collision(obstacles, position_x, position_y)
    collision = false
    obstacles.each do |obstacle|
      collision = obstacle.collision(position_x, position_y)
      break if collision
    end
    collision
        end
  end

