require "redis"

require "dtv_tournaments/version"
require "dtv_tournaments/utilities"
require "dtv_tournaments/cache"
require "dtv_tournaments/tournament"

module DTVTournaments
  def self.get number, rerun=false
    if rerun
      DTVTournaments::Tournament.new(number)
    else
      DTVTournaments.get_cached_tournament(number)
    end
  end

  def self.get_cached_tournament(number)
    cached = DTVTournaments.get_cache.get_by_number(number)
    if cached.nil?
      DTVTournaments.get(number, true)
    else
      cached
    end
  end
end
