  Sidekiq.configure_server do |config|
    config.redis = { url:'redis://****:*****1@pub-******.us-east-1-3.2.ec2.garantiadata.com:*****'}
  end

  Sidekiq.configure_client do |config|
    config.redis = { url:'redis://****:*****1@pub-******.us-east-1-3.2.ec2.garantiadata.com:*****'}
  end
