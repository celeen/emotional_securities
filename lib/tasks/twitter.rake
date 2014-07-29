
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

    count = 0

    symbols = ['AAPL', 'GOOG', 'TSLA', 'CHTP', 'SBUX', '$YHOO', 'CMI', 'TSN', 'AFL', 'AXP', 'AMGN', 'CBG', 'LVLT', 'HMC', 'MRK', 'TWTR']

    TweetStream::Client.new.track(symbols, language: 'en') do |tweet|

      companies = symbols.map { |symbol| symbol if /#{symbol.downcase}/.match(tweet.text.downcase) }
        companies.compact!
        companies = nil if companies.empty?



        companies.each do |symbol|
          tweet_args = {tweet_id: tweet.id, text: tweet.text, tweeted_at: tweet.created_at, company: symbol }
          puts "IN ARGS ************************************"
          puts "------#{tweet_args} ----- #{symbol}----------------- #{count}-------------#{symbols}"
          TweetWorker.perform_async(tweet_args, symbol, count, symbols)
        end
        count += 1 # no extra dynos
    end
  end
end
