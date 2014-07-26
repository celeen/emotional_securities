
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
    Feedjira::Feed.fetch_and_parse("http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol="+a.symbol.upcase)

    i = 0

    TweetStream::Client.new.track('AAPL') do |tweet|
      #logic here
      # tweet = Tweet.create(tweet)
      puts tweet.to_json
      puts tweet.text
      puts tweet.created_at
      puts tweet.id

      TweetWorker.perform_async(tweet.id)
      i += 1 # no extra dynos
      if i % 1000 == 0
        Aticle.create_feeds(["http://finance.yahoo.com/rss/headline?s=aapl", "http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=AAPL"])
      end
    end
  end
end
