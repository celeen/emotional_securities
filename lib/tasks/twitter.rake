
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
    stock_tickers = []

    a = Company.create(name:"Apple", symbol:"aapl")

    TweetStream::Client.new.track('AAPL') do |tweet|

      tweet_args = {tweet_id: tweet.id, text: tweet.text, tweeted_at: tweet.created_at }

      TweetWorker.perform_async(tweet_args)

    end
  end
end
