require 'mechanize'

module DTVTournaments
  class Tournament
    attr_accessor :number, :notes, :date, :time, :datetime, :street, :zip, :city, :kind, :page
    def initialize number
      @number = number
      call
    end

    def rerun
      call false
    end

    def call cached=  true
      # TODO: Support cached option later
      get_result_page
      extract_results
    end

    def get_result_page
      mechanize = Mechanize.new { |agent|
        agent.read_timeout = 3
      }

      mechanize.get(DTVTournaments::FETCHINGURL)
      search_form = mechanize.page.forms.last

      search_form.nr = @number
      search_form.submit

      @page = mechanize.page
    end

    def extract_results
      extract_kind
      extract_notes
      extract_location
      extract_time
    end

    def extract_kind
      @kind = DTVTournaments::convertToText(page.search(".markierung .turnier"))
    end

    def extract_notes
      @notes = page.search(".turniere tr .bemerkung").to_a.collect(&:text).reject{|x| x.nil? || x.empty?}.join("\n")
    end

    def extract_location
      # TODO
    end

    def extract_time
      if page.search(".markierung .uhrzeit").first.text.empty?
        # This tournament is a big one
        time = get_time_from_big_tournament(page.search(".turniere tr"))
      else
        time = page.search(".markierung .uhrzeit").text.scan(/\d{1,2}:\d{2}/).first
      end
      date = page.search(".kategorie").text.scan(/^\d{1,2}.\d{1,2}.\d{4}/).first

      puts time

      @datetime = DateTime.parse("#{date} #{time}")
      @date     = Date.parse(date)
      @time     = Time.parse("#{date} #{time}")
    end

    def get_index_of_marked_tournament tournaments
      tournaments.each_with_index do |single_tournament, index|
        return index if single_tournament.attributes().has_key?('class')
      end
    end

    def get_first_time_until times, index
        for i in (0..index).to_a.reverse
          return times[i] unless times[i].nil? || times[i].empty?
        end
    end

    def get_time_from_big_tournament tournaments

      times = tournaments.map do |single_tournament|
        next_time = DTVTournaments::get_subelement_if_available(single_tournament, ".uhrzeit")

        if next_time.nil? || next_time.empty?
          nil
        else
          next_time.scan(/\d{1,2}:\d{2}/).first
        end
      end

      index = get_index_of_marked_tournament tournaments
      get_first_time_until(times, index)
    end
  end
end


__END__

DTVTournaments.Tournament.new 38542
