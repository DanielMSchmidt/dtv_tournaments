require 'mechanize'

module NumberFetcher
  attr_accessor :number, :rerun, :cached
  PREFIX = "tr"
  FETCHINGURL = "http://appsrv.tanzsport.de/td/db/turnier/einzel/suche"

  def self.get_by_number number, options={}
    @number = number
    @rerun = options[:rerun] || false
    @cached = options[:cached] || false

    # Rails.cache.delete("#{NumberFetcher::PREFIX}-#{@number}") if @rerun

    if @cached
      NumberFetcher::get_cached_tournament_data
    else
      get_tournament_data
    end
  end

  def self.get_cached_tournament_data
    #return Rails.cache.fetch("#{NumberFetcher::PREFIX}-#{@number}") do
    self.get_tournament_data
    #end
  end

  def self.get_tournament_data
    puts "Tournament data is fetching for #{@number}"
    hash = NumberFetcher::extract_results(NumberFetcher::get_result_page(@number))
    hash[:number] = @number
    hash
  end

  def self.get_result_page(number)
    mechanize = Mechanize.new { |agent|
      agent.read_timeout = 3
    }

    mechanize.get(NumberFetcher::FETCHINGURL)
    search_form = mechanize.page.forms.last

    search_form.nr = number
    search_form.submit

    mechanize.page
  end

  def self.extract_results page
    raw_data = NumberFetcher::get_raw_data(page)
    extracted_results = {}
    raw_data.each do |key, value|
      extracted_results[key] = send("extract_#{key}", value) unless value.nil?
    end
    create_time_and_date extracted_results
  end

  def self.create_time_and_date hash
    time = hash.delete(:time)
    date = hash.delete(:date)
    hash[:datetime] = DateTime.parse("#{date} #{time}")
    hash[:date]     = Date.parse(date)
    hash[:time]     = Time.parse("#{date} #{time}")
    hash
  end

  def self.extract_kind(content)
    NumberFetcher::convert_to_text(content)
  end

  def self.extract_date(content)
    NumberFetcher::convert_to_text(content).scan(/^\d{1,2}.\d{1,2}.\d{4}/).first
  end

  def self.extract_time(content)
    NumberFetcher::convert_to_text(content).scan(/\d{1,2}:\d{2}/).first
  end

  def self.extract_notes(content)
    NumberFetcher::convert_to_text(content)
  end

  def self.extract_street(content)
    NumberFetcher::convert_to_text(content).split("\t").join("").split("\n").delete_if{|x| x.empty? }.join(" ")
  end

  def self.extract_zip(content)
    content.text.gsub(/(\W)/, "").gsub(/(\D)/, "")
  end

  def self.extract_city(content)
    content.text.gsub(/(\W)/, "").gsub(/(\d)/, "")
  end

  def self.convert_to_text(content)
    if content.class ==  String
      content
    else
      content.text
    end
  end

  def self.get_raw_data(page)
    #Test id its a multiline tournament
    if page.search(".markierung .uhrzeit").first.text.empty?
      puts "This Tournament seems to be a big one: #{@number}"

      page.search(".turniere tr").each do |single_tournament|
        next_kind = NumberFetcher::get_subelement_if_available(single_tournament, ".turnier")
        kind = next_kind unless next_kind.nil? || next_kind.empty?

        next_time = NumberFetcher::get_subelement_if_available(single_tournament, ".uhrzeit")
        time = next_time unless next_time.nil? || next_time.empty?

        break if single_tournament.attributes().has_key?('class')
      end
    else
      kind = page.search(".markierung .turnier")
      time = page.search(".markierung .uhrzeit")
    end
    notes = page.search(".turniere tr .bemerkung").to_a.collect(&:text).reject{|x| x.nil? || x.empty?}.join("\n")
    date = page.search(".kategorie")
    street = page.search(".ort")
    street.search("strong").remove # remove zip and city from field
    zip = page.search(".ort strong")
    city = page.search(".ort strong")
    { kind: kind, date: date, time: time, notes: notes, street: street, zip: zip, city: city }
  end

  def self.get_subelement_if_available(element, selector)
    unless element.search(selector).first.nil?
      element.search(selector).first.text
    else
      nil
    end
  end
end

__END__

DtvTournaments.get_by_number(38543)
