module AppleShove
  CONFIG = { 
    :redis_uri     => ENV["REDISTOGO_URL"],
    :redis_key        => 'apple_shove',
    :reconnect_timer  => 5              # timeout in minutes to re-establish APNS connection  
  }
end