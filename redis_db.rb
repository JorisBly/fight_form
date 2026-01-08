require 'redis'
class RedisDb < Redis
  def initialize(**args)
    super(**args)
  end

  def get_scores()
    zrange("scores", 0, -1, with_scores: true)
  end
  def get_score(player)
    # zrange("scores", 0, -1)
  end

  def save_score(player, time)
    zadd("scores",  time, player.name)
  end
end