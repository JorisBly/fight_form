class Coin < Sprite
  attr_accessor :sound
  def initialize(path, sound, **args)
    super(path, **args)
    @sound = Sound.new(sound)
    puts "Pièce initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def destroy
    self.remove
  end

  def play_sound
    @sound.play
  end

  def collision(position_x, position_y)
      if self.x === position_x  && self.y === position_y
      true
    else false
    end
  end

  def catched
    puts "Catched !"
    self.play_sound
    self.destroy
  end

end