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

  def catched(position_x, position_y)
    if self.x === position_x  && self.y === position_y
      puts "Catched !"
      self.destroy
      true
    else
      false
    end
  end

end