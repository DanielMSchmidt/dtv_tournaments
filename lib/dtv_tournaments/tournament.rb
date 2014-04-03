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

    def call cached=true
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
      if @page.search(".markierung .uhrzeit").first.text.empty?
        # This tournament is a big one
        page.search(".turniere tr").each do |single_tournament|
          next_kind = NumberFetcher::get_subelement_if_available(single_tournament, ".turnier")
          kind = next_kind unless next_kind.nil? || next_kind.empty?

          break if single_tournament.attributes().has_key?('class')
        end
      else
        kind = page.search(".markierung .turnier")
      end

      @kind = DTVTournaments::convertToText(kind)
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
        page.search(".turniere tr").each do |single_tournament|
          next_time = NumberFetcher::get_subelement_if_available(single_tournament, ".uhrzeit")
          time = next_time unless next_time.nil? || next_time.empty?

          break if single_tournament.attributes().has_key?('class')
        end
      else
        time = page.search(".markierung .uhrzeit")
      end
      date = DTVTournaments::convertToText(page.search(".kategorie")).scan(/^\d{1,2}.\d{1,2}.\d{4}/).first
      time = DTVTournaments::convertToText(time).scan(/\d{1,2}:\d{2}/).first

      @datetime = DateTime.parse("#{date} #{time}")
      @date     = Date.parse(date)
      @time     = Time.parse("#{date} #{time}")
    end
  end
end


__END__

DTVTournaments.Tournament.new 38542
