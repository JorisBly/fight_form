require 'ruby2d'
require './player'
require './wall'
require './game'
require './main_screen'
require './score_screen'
require './select_map_screen'
require './redis_db'
require './models/mongo_db'

redis = RedisDb.new(host: "localhost", port: 6379)
set title: "Fight Form"
WIDTH = 1920
HEIGHT = 1080
TILE_SIZE = 128
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
      when 'close' then close
      when 'game'
        current_screen.close
        current_screen = SelectMapScreen.new
      when 'scores'
        current_screen.close
        current_screen = ScoreScreen.new(redis.get_scores)
      end
    when 'down' then current_screen.selected_choice += 1
    when 'up'   then current_screen.selected_choice -= 1
    end

  when ScoreScreen
    case event.key
    when 'escape'
      current_screen.close
      current_screen = MainScreen.new
    when 'down' then current_screen.selected_score += 1
    when 'up'   then current_screen.selected_score -= 1
    end

  when SelectMapScreen
    case event.key
    when 'return'
      choice = current_screen.validated_choice
      current_screen.close
      current_screen = Game.new(WIDTH, HEIGHT, ARGV[0] || 'Player', JSON.parse(Level.get_map(choice)), TILE_SIZE)
      current_screen.start
    when 'escape'
      current_screen.close
      current_screen = MainScreen.new
    when 'down' then current_screen.selected_choice += 1
    when 'up'   then current_screen.selected_choice -= 1
    end

  when Game
    case event.key
    when 'left'  then current_screen.move(current_screen.player.x - TILE_SIZE, current_screen.player.y)
    when 'right' then current_screen.move(current_screen.player.x + TILE_SIZE, current_screen.player.y)
    when 'up'    then current_screen.move(current_screen.player.x, current_screen.player.y - TILE_SIZE)
    when 'down'  then current_screen.move(current_screen.player.x, current_screen.player.y + TILE_SIZE)
    end
  end
end

update do
  current_screen.update
  case current_screen
  when Game
    if current_screen.map.coins.empty?
      redis.save_score(current_screen.player, current_screen.elapsed)
      current_screen.close
      current_screen = MainScreen.new
    end
  end

end

show