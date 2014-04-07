require 'spec_helper'
describe DTVTournaments::Cache do
  before(:all) do
    @cache = DTVTournaments.get_cache
  end
  it "should return the same as given in" do
    t1 = DTVTournaments::Tournament.new(38542)
    @cache.set(t1)
    t2 = @cache.get_by_number(38542)

    expect(t1.number).to eq(t2.number)
    expect(t1.notes).to eq(t2.notes)
    expect(t1.kind).to eq(t2.kind)
    expect(t1.datetime.to_s).to eq(t2.datetime.to_s)
    expect(t1.date.to_s).to eq(t2.date.to_s)
    expect(t1.time.to_s).to eq(t2.time.to_s)
  end
end
