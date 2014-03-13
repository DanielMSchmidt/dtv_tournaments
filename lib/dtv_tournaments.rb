require "dtv_tournaments/version"
require "dtv_tournaments/number_fetcher"

# Proxy object
module DtvTournaments
  def self.get_by_number number, options={}
    NumberFetcher.get_by_number number, options
  end
end
