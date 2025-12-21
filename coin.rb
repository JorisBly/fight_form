class Coin < Sprite

  def initialize(path, sound, **args)
    super(path, **args)
    @sound = Sound.new(sound)
    puts "Pièce initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def destroy
    remove
  end

  def play_sound
    @sound.play
  end

  def catched(position_x, position_y)
    if x === position_x  && y === position_y
      puts "Catched !"
      destroy
      true
    else
      false
    end
  end

end