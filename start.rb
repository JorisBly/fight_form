require 'ruby2d'
require './player'
require './wall'
require './game'
require './main_screen'
require './database'

redis = Database.new(host: "localhost", port: 6379)
set title: "Fight Form"
WIDTH = 1500
HEIGHT = 750
set viewport_width: WIDTH + 30
set viewport_height: HEIGHT + 30
set borderless: true
set fullscreen: false
set resizable: true


current_screen = MainScreen.new 





on :key_down do |event|
  case current_screen
  when MainScreen
    case event.key
    when 'return'
      current_screen = current_screen.validated_choice
      current_screen.start
    when 'down'
      current_screen.selected_choice += 1
    when 'up'
      current_screen.selected_choice -= 1
    end

  end
end

on :key_down do |event|
  case current_screen
    when Game
     case event.key
        when 'left'
          current_screen.player.move_left(30, current_screen.map.coins, current_screen.map.tiles)
        when 'right'
          current_screen.player.move_right(30, current_screen.map.coins, current_screen.map.tiles)
        when 'up'
          current_screen.player.move_up(30, current_screen.map.coins, current_screen.map.tiles)
        when 'down'
          current_screen.player.move_down(30, current_screen.map.coins, current_screen.map.tiles)
    end
  end

end

update do
  case current_screen
  when MainScreen
    current_screen.update
  when Game
    current_screen.update
    if Time.now - current_screen.time_start > 60
      close
      redis.save_score(@player)
    end
  end

end

show