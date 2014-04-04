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
  end

  describe "options" do
    it "should not take the cache if rerun is passed"
    it "should update the cache if rerun is passed"
    it "should not take cached if cached isn't passed"
    it "should take the cached if cached is"
  end
end
