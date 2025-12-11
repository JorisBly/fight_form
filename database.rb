require 'redis'
class Database < Redis
  def initialize(**args)
    super(**args)
  end

  def get_score(player)

  end

  def save_score(player)
    zadd("scores",  player.points, player.name)
  end
end