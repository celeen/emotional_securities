
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

    i = 0
    symbols = ['AAPL', 'GOOG', 'TSLA', 'CHTP', 'SBUX','$FB', '$YHOO']
    TweetStream::Client.new.track(symbols, language: 'en') do |tweet|

      puts 'in client'
      p tweet.to_h

      i += 1 # no extra dynos
      if i % 1000 == 0
        Article.create_feeds(["http://finance.yahoo.com/rss/headline?s=aapl", "http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=AAPL"])
      end

      puts '----PAST THE INFALLIBLE ZONE-----------'
      p "#{tweet.text}"


      companies = symbols.map { |symbol| symbol if /#{symbol.downcase}/.match(tweet.text.downcase) }
      companies.compact!

      p "------#{companies}---------"

      companies.each do |symbol| 
        tweet_args = {tweet_id: tweet.id, text: tweet.text, tweeted_at: tweet.created_at, company: symbol }
        puts "IN ARGS ************************************"
        TweetWorker.perform_async(tweet_args, symbol) 
      end

    end
  end
end
