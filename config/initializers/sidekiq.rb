Sidekiq.configure_server do |config|
  redis_url = ENV.fetch('REDIS_URL') { 'redis://redis:6379/0' }
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  redis_url = ENV.fetch('REDIS_URL') { 'redis://redis:6379/0' }
  config.redis = { url: redis_url }
end
