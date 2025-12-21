# frozen_string_literal: true

class Wall < Sprite

  def initialize(path, sound, **args)
    super(path, **args)
    @sound = Sound.new(sound)
  end

  def play_sound
    @sound.play
  end

  def collision(position_x, position_y)
    if x === position_x  && y === position_y && !path.include?("terrain")
      puts "Collision !"
      true
    else
      false
    end
  end

end
