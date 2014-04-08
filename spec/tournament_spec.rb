require 'spec_helper'
describe DTVTournaments::Tournament do
  describe "results" do
    describe "large tournaments" do
      before(:all) do
        @t = DTVTournaments.get(40472, true)
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
        @t = DTVTournaments.get(38542, true)
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
        DTVTournaments.should_receive(:get_cached_tournament).with(38542)

        DTVTournaments.get(38542)
      end

      it "should fetch normally if not found in cache" do
        cache = double('Cache', :get_by_number => nil)

        DTVTournaments.should_receive(:get_cache).and_return(cache)
        DTVTournaments::Tournament.should_receive(:new).with(38542)

        DTVTournaments.get(38542)
      end

      it "should save to cache if not found in cache" do
        cache = double('Cache', :get_by_number => nil)
        cache.should_receive(:set)
        DTVTournaments.should_receive(:get_cache).at_least(1).and_return(cache)

        DTVTournaments.get(38542)
      end

      it "should save to cache if rerun is set" do
        cache = double('Cache', :get_by_number => nil)
        cache.should_receive(:set)
        DTVTournaments.should_receive(:get_cache).and_return(cache)

        DTVTournaments.get(38542, true)
      end

      it "should not ask the cache if rerun is set" do
        cache = double('Cache', :set => nil)
        cache.should_not_receive(:get_by_number)
        DTVTournaments.should_receive(:get_cache).and_return(cache)

        DTVTournaments.get(38542, true)
      end
    end
  end

  describe "options" do
    after(:each) do
        DTVTournaments.reset_cache_config
    end

    it "should have a deactivated cache" do
      DTVTournaments.get_cache.redis.should be_nil
    end

    it "should be possible to configure a redis cache" do
      DTVTournaments.configure_cache do |config|
        config[:active] = true
        config[:host] = '10.0.1.42'
        config[:port] = 6342
        config[:db]   = 15
      end
      Redis.should_receive(:new).with(:host => "10.0.1.42", :port => 6342, :db => 15)

      DTVTournaments::Cache.new
    end
  end
end
