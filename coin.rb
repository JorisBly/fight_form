class Coin < Sprite

  def initialize(path, sound, **args)
    super(path, **args)
    @sound = Sound.new(sound)
    puts "Pièce initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def play_sound
    @sound.play
  end
end