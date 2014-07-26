
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

    a = Company.create(name:"Apple", symbol:"aapl")

    TweetStream::Client.new.track('AAPL') do |tweet|
      #logic here
      # tweet = Tweet.create(tweet)
      puts tweet.to_json
      puts tweet.text
      puts tweet.created_at
      puts tweet.id



      quote = a.quotes.create(price: StockQuote::Stock.quote('aapl').last_trade_price_only, volume: StockQuote::Stock.quote("aapl").volume, )
      puts "quote price is: #{quote.price}"

      TweetWorker.perform_async({tweet_id: tweet.id, text: tweet.text, tweeted_at: created_at})

      # tweet = a.tweets.create(text: tweet.text, tweeted_at: tweet.created_at, tweet_id: tweet.id,)
      # puts "Tweet id after save is: #{tweet.tweet_id}"

    end
  end
end
