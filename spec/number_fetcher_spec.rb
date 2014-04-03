require 'spec_helper'
describe NumberFetcher do
  describe "results" do
    describe "large tournaments" do
      it "should have the right date"
      it "should have the right address"
      it "should have the right kind"
    end
    describe "small tournaments" do
      it "should have the right date"
      it "should have the right address"
      it "should have the right kind"
    end
  end

  describe "options" do
    it "should not take the cache if rerun is passed"
    it "should update the cache if rerun is passed"
    it "should not take cached if cached isn't passed"
    it "should take the cached if cached is"
  end
end
