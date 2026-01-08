class ScoreScreen
  attr_accessor :title , :scores, :selected_score, :back_button, :scores_text
  def initialize(scores)
    @title = Text.new('FIGHT FORM',size: 150, y: 40, x: 500)
    @selected_score = 0
    @scores = scores
    @scores_text = []
    @back_button = Text.new('<ESC> Back', size: 64, y: 950, x: (WIDTH / 2) - 150)
    display_scores
  end

  def update()
    navigate
  end

  def display_scores
    last_index = 0
    @scores.each do |score|
      @scores_text << Text.new("#{score[0]} : #{score[1].truncate(2)}", size: 64, x: (WIDTH / 2) - 100, y: (HEIGHT / 4) + (last_index * 100))
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
