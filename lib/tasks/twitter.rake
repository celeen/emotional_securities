
include Sidekiq::Worker

namespace :stream do
  desc 'collecting tweets script'
  task:emo_grabber => :environment do
    TweetStream.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY']
      config.consumer_secret    = ENV['CONSUMER_SECRET']
      config.oauth_token        = ENV['OAUTH_TOKEN']
      config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
      config.auth_method        = :oauth
    end

    tweet_array = []


    TweetStream::Client.new.track('AAPL') do |tweet|
      #logic here
      # tweet = Tweet.create(tweet)
      puts tweet.attrs

      #Quote.create(price: StockQuote::Stock.quote('aapl').last_trade_price_only, volume: StockQuote::Stock.quote("aapl").volume, )
      TweetWorker.perform_async(tweet.id)
    end
  end
end
