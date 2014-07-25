
include Sidekiq::Worker 

namespace :stream do
  desc 'collecting tweets script'
  task:emo_grabber => :environment do
    TweetStream.configure do |config|
      config.consumer_key       =  'TYwpP4TNiWNvuazPw99SlTwzH' #ENV['CONSUMER_KEY']
      config.consumer_secret    =  'IqsK9FueHwHPAdG0BbyASeZx6LbyirxKMBRtxITNfLG4DjHpct' #ENV['CONSUMER_SECRET']
      config.oauth_token        =  '62701231-wnRMFbObP24aeIPhINl1JtW20GWQmb25mCSXyF6XR' #ENV['OAUTH_TOKEN']
      config.oauth_token_secret =  'iKUJ96BLsSydmIUzPPCE9tgmcK4rMKwDx3wa2lkh9Ciyu' #ENV['OAUTH_TOKEN_SECRET']
      config.auth_method        = :oauth
    end

    tweet_array = []


    TweetStream::Client.new.track('AAPL') do |tweet|
      #logic here
      # tweet = Tweet.create(tweet)
      puts tweet.attrs 
      TweetWorker.perform_async(tweet.id)
      
      
    end
  end
end
