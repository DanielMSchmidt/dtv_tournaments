require 'redis'

module DTVTournaments
  class << self
    attr_writer :cache_configuration, :cache
  end

  def self.cache_configuration
    reset_cache_config if @cache_configuration.nil?
    @cache_configuration
  end

  def self.reset_cache_config
    @cache_configuration = {:host => '127.0.0.1', :port => 6379, :db => 1, :active => false}
  end

  def self.configure_cache
    yield(cache_configuration)
  end

  def self.get_cache
    @cache ||= Cache.new
  end

  class Cache < Struct.new(:redis)
    def initialize
      config = DTVTournaments.cache_configuration
      active = config.delete(:active)

      @redis = Redis.new(config) if active
    end

    def get_by_number(number)
      data = @redis.get(number) unless @redis.nil?
      return nil if data.nil?
      Tournament.deserialize(Cache.toDataArray(data))
    end

    def self.toDataArray(data)
      data.split('|')
    end

    def set(tournament)
      @redis.set(tournament.number, tournament.serialize) unless @redis.nil?
    end
  end
end
