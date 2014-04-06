require 'redis'

module DTVTournaments
  class << self
    attr_writer :cacheConfiguration, :cache
  end

  def self.cacheConfiguration
    resetCacheConfig if @cacheConfiguration.nil?
    @cacheConfiguration
  end

  def self.resetCacheConfig
    @cacheConfiguration = {:host => '127.0.0.1', :port => 6379, :db => 1}
  end

  def self.configureCache
    yield(cacheConfiguration)
  end

  def self.getCache
    @cache ||= Cache.new
  end

  class Cache < Struct.new(:redis)
    def initialize
      config = DTVTournaments.cacheConfiguration
      @redis = Redis.new(config)
    end

    def getByNumber(number)
      data = @redis.get(number)
      # TODO: Deserialize
      data
    end

    def setByNumber(number, tournament)
      # TODO: Serialize
      @redis.set(number, tournament)
    end
  end
end
