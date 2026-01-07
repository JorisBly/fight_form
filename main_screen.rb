class MainScreen
  attr_accessor :title, :choices, :selected_choice, :previous_selection

  def initialize
    @title = Text.new('FIGHT FORM',size: 150, y: 40, x: 250)
    @choices = [
      Text.new('Start', size: 72, y: 220, x: 650),
      Text.new('Scores', size: 72, y: 320, x: 650),
      Text.new('Quit', size: 72, y: 420, x: 650)
    ]
    @selected_choice = 0
    @previous_selection = 0

    def update()
      navigate_choice
    end
    def navigate_choice()
        @choices[@previous_selection].color = 'white'
        @choices[(@selected_choice) % 3].color = 'blue'
        @previous_selection = @selected_choice % 3
        @selected_choice = @selected_choice % 3
    end

    def validated_choice()
      case @selected_choice
      when 0
        return 'game'
      when 1
        return 'scores'
      when 2
        return 'close'
      end
    end

    def close()
      @title.remove
      @choices.each do |choice|
        choice.remove
      end
    end
    end
  end
