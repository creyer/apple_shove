module AppleShove
  CONFIG = { 
    :redis_uri     => 'redis://localhost:6379',
    :redis_key        => 'apple_shove',
    :reconnect_timer  => 5              # timeout in minutes to re-establish APNS connection  
  }
end