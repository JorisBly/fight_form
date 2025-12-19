# frozen_string_literal: true

class MainScreen
  attr_accessor :title, :choices, :selected_choice

  def initialize
    @title = Text.new('FIGHT FORM', size: 72, y: 40)
    @choices = [
      Text.new('Start', size: 36, y: 200),
      Text.new('Quit', size: 36, y: 260),
      # Text.new('Scores', size: 36, y: 320)
    ]
    @selected_choice = 0

    def update()
      navigate_choice
    end
    def navigate_choice()
        @choices[(@selected_choice - 1) % 2].color = 'white'
        @choices[(@selected_choice) % 2].color = 'blue'
    end

    def validated_choice()
      case @selected_choice
      when 0
        return Game.new(WIDTH, HEIGHT, player_name: 'Joris')
      when 1
        return close
      end
    end
    end
  end
