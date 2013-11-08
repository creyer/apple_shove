require 'json'
require 'redis'

module AppleShove
  class NotificationQueue
    
    def initialize(key, redis = nil)
      if CONFIG[:redis_uri]
        uri = URI.parse(CONFIG[:redis_uri])
        redis ||= Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      else
        redis ||= ::Redis.new
      end
      @redis = redis
      @key = key
    end
    
    def add(notification)
      @redis.rpush @key, notification.to_json
    end
    
    def get
      element = @redis.lpop @key
      element ? Notification.parse(element) : nil
    end

    def size
      @redis.llen @key
    end   

  end
end