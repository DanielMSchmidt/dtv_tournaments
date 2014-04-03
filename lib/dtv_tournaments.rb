require "dtv_tournaments/version"
require "dtv_tournaments/tournament"


# Constants and helper
module DTVTournaments
  FETCHINGURL = "http://appsrv.tanzsport.de/td/db/turnier/einzel/suche"

  def self.convertToText content
    if content.class == String
      content
    else
      content.text
    end
  end
end
