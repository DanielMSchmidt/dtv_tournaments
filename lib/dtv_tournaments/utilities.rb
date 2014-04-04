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
  
  def self.get_subelement_if_available(element, selector)
    unless element.search(selector).first.nil?
      element.search(selector).first.text
    else
      nil
    end
  end
end
