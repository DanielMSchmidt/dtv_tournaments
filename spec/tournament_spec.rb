require 'spec_helper'
describe DTVTournaments::Tournament do
  describe "results" do
    describe "large tournaments" do
      before(:all) do
        @t = DTVTournaments::Tournament.new(40472)
      end

      it "should have the right date" do
        expect(@t.date.to_s).to eq(Date.parse('20.04.2014').to_s)
        expect(@t.time.hour).to eq(Time.parse('09:00').hour)
        expect(@t.time.min).to eq(Time.parse('09:00').min)
        expect(@t.datetime.to_s).to eq(DateTime.parse('20.04.2014 09:00').to_s)
      end

      it "should have the right address"
      it "should have the right kind" do
        expect(@t.kind).to eq('HGR C LAT')
      end
    end

    describe "small tournaments" do
      before(:all) do
        @t = DTVTournaments::Tournament.new(38542)
      end

      it "should have the right date" do
        expect(@t.date.to_s).to eq(Date.parse('29.03.2014').to_s)
        expect(@t.time.hour).to eq(Time.parse('15:30').hour)
        expect(@t.time.min).to eq(Time.parse('15:30').min)
        expect(@t.datetime.to_s).to eq(DateTime.parse('29.03.2014 15:30').to_s)
      end

      it "should have the right address"
      it "should have the right kind" do
        expect(@t.kind).to eq('HGR D ST')
      end
    end

    describe "caching" do
      it "should ask the cache if tournament would be fetched" do
        cache = double()
        cache.should_receive(:getByNumber).and_return(nil)
        DTVTournaments.stub(:getCache).and_return(cache)

        DTVTournaments::Tournament.new(38542)
      end
    end
  end

  describe "options" do
    it "should be possible to configure a redis cache" do
      DTVTournaments.configureCache do |config|
        config[:host] = '10.0.1.42'
        config[:port] = 6342
        config[:db]   = 15
      end
      Redis.should_receive(:new).with(:host => "10.0.1.42", :port => 6342, :db => 15)

      DTVTournaments::Cache.new
      DTVTournaments.resetCacheConfig
    end
  end
end
