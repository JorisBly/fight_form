# frozen_string_literal: true

class Wall < Sprite

  def initialize(path, sound, **args)
    super(path, **args)
    @sound = Sound.new(sound)
  end

  def play_sound
    @sound.play
  end
end
