# frozen_string_literal: true

class Collectible < Sprite
  def initialize(path, **args)
    super(path, **args)
    puts "Collectible initialisé: x=#{@x} y=#{@y} width=#{@width} height=#{@height}"
  end

  def destroy()
    self.remove
  end
end
