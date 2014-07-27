require 'alchemiapi'

class TweetWorker
	include Sidekiq::Worker

	def perform(tweet_args)
		get_stock_quote

		tweet_args[:sentiment] = get_alchemy_response(tweet_args['text'])

		create_tweet(tweet_args)
	end

	def get_alchemy_response(text)
		puts text
		response = AlchemyAPI.new.sentiment('text', text)
		puts response
		response['docSentiment']['score'].to_f
	end

	def create_tweet(tweet_args)
		apple = Company.find_by(symbol: 'aapl')
		puts "Within the create method: #{apple.tweets}"
		apple.tweets.create!(tweet_args)
	end

end

	def get_stock_quote(symbol = 'aapl')
		comp = Company.find_by(symbol: symbol)
	  last_price = StockQuote::Stock.quote(comp.symbol).last_trade_price_only
    volume = StockQuote::Stock.quote(comp.symbol).volume
		comp.quotes.create(price: last_price, volume: volume)
	end

end

