class SelectMapScreen
  attr_accessor :title, :choices, :selected_choice, :previous_selection

  def initialize
    @title = Text.new('FIGHT FORM',size: 150, y: 40, x: 500)
    @choices = [
      Text.new('Level 1', size: 72, y: 220, x: (WIDTH / 2) - 100),
      Text.new('Level 2', size: 72, y: 320, x: (WIDTH / 2) - 100),
      Text.new('Level 3', size: 72, y: 420, x: (WIDTH / 2) - 100),
    ]
    @selected_choice = 0
    @previous_selection = 0
    @back_button = Text.new('<ESC> Back', size: 64, y: 950, x: (WIDTH / 2) - 150)

    def update
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
        return 'level_1'
      when 1
        return 'level_2'
      when 2
        return 'level_3'
      end
    end

    def close()
      @title.remove
      @choices.each do |choice|
        choice.remove
      end
      @back_button.remove
    end
  end
end