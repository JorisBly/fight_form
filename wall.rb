# frozen_string_literal: true

class Wall < Sprite
  attr_accessor :sound
  def initialize(path, sound, **args)
    super(path, **args)
    @sound = Sound.new(sound)
  end

  def play_sound
    @sound.play
  end

  def collision(position_x, position_y)
      if self.x === position_x  && self.y === position_y && !self.path.include?("terrain")
          puts "Collision !"
          true
        else false
      end
  end

end
