class ScoreScreen
  attr_accessor :title , :scores, :selected_score, :back_button, :scores_text
  def initialize(scores)
    @title = Text.new('FIGHT FORM',size: 150, y: 40, x: 250)
    @selected_score = 0
    @scores = scores
    @scores_text = []
    @back_button = Text.new('<ESC> Back', size: 36, y: 650, x: 600)
    display_scores
  end

  def update()
    navigate
  end

  def display_scores
    last_index = 0
    @scores.each do |score|
      @scores_text << Text.new("#{score[0]} : #{score[1]}", size: 36, x: 600, y: 250 + (last_index * 50))
      last_index += 1
    end
  end
  def navigate
    @scores[(@selected_score - 1) % 2].color = 'white'
    @scores[(@selected_score) % 2].color = 'blue'
  end

  def close
    @title.remove
    @scores_text.each do |score|
      score.remove
    end
    @back_button.remove
  end
end
