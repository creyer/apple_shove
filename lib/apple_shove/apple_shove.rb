module AppleShove

  def self.notify(params = {})
    notification = Notification.new params

    queue = NotificationQueue.new(CONFIG[:redis_key])
    queue.add(notification)

    true
  end

  def self.feedback_tokens(p12, sandbox = false)
    conn = APNS::FeedbackConnection.new p12, sandbox

    conn.device_tokens
  end

  def self.stats
    if CONFIG[:redis_uri]
      uri = URI.parse(CONFIG[:redis_uri])
      redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    else
      redis = ::Redis.new
    end
    queue = NotificationQueue.new(CONFIG[:redis_key], redis)

    size = queue.size

    redis.quit
    
    "queue size:\t#{size}"
  end

  # raises an exception if the p12 string is invalid
  def self.try_p12(p12)
    OpenSSLHelper.pkcs12_from_pem(p12)
    true
  end
  
end