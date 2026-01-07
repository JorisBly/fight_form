require 'ruby2d'
require './player'
require './wall'
require './game'
require './main_screen'
require './score_screen'
require './database'

redis = Database.new(host: "localhost", port: 6379)
set title: "Fight Form"
WIDTH = 1280
HEIGHT = 720
set viewport_width: WIDTH
set viewport_height: HEIGHT
set borderless: false
set fullscreen: false


current_screen = MainScreen.new 



on :key_down do |event|
  case current_screen
  when MainScreen
    case event.key
    when 'return'
      choice = current_screen.validated_choice
        case choice
          when 'close'
              close
          when 'game'
              current_screen.close
              current_screen = Game.new(WIDTH, HEIGHT, ARGV[0] || 'Player', ARGV[1] || 'media/map_1.txt')
              current_screen.start
          when 'scores'
              current_screen.close
              current_screen = ScoreScreen.new(redis.get_scores)
      end
    when 'down'
      current_screen.selected_choice += 1
    when 'up'
      current_screen.selected_choice -= 1
    end

  end
end

on :key_down do |event|
  case current_screen
    when ScoreScreen
      case event.key
        when 'escape'
          current_screen.close
          current_screen = MainScreen.new
        when 'down'
          current_screen.selected_score += 1
    when 'up'
          current_screen.selected_score -= 1
    end

  end
end

on :key_down do |event|
  case current_screen
    when Game
     case event.key
        when 'left'
          current_screen.move(current_screen.player.x - 64, current_screen.player.y)
        when 'right'
          current_screen.move(current_screen.player.x + 64, current_screen.player.y)
        when 'up'
          current_screen.move(current_screen.player.x , current_screen.player.y - 64)
        when 'down'
          current_screen.move(current_screen.player.x , current_screen.player.y + 64)
    end
  end

end

update do
  case current_screen
  when MainScreen
    current_screen.update
  when Game
    current_screen.update
    if Time.now - current_screen.time_start > 10
      redis.save_score(current_screen.player)
      current_screen.close
      current_screen = MainScreen.new
    end
  end

end

show