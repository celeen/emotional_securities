require 'alchemiapi'

class TweetWorker
	include Sidekiq::Worker

	def perform(tweet_args, symbol, count, symbols)

		get_stock_quote(symbol)

		tweet_args[:sentiment] = get_alchemy_response(tweet_args['text'])

		create_tweet(tweet_args)

		if count % 5000 == 0
			update_rss(symbols)
		end
	end

	def get_alchemy_response(text)
		# puts text
		response = AlchemyAPI.new.sentiment('text', text)
		# puts response
		response['docSentiment']['score'].to_f
	end

	def create_tweet(tweet_args)
		Tweet.create(tweet_args)
	end

	def get_stock_quote(symbol = 'aapl')
		# puts '---MAKING QUOTE------'
	  last_price = StockQuote::Stock.quote(symbol).last_trade_price_only
    volume = StockQuote::Stock.quote(symbol).volume
    # puts "---#{volume}------"
    # puts "---#{last_price}------"
		Quote.create(price: last_price * 100, volume: volume, company: symbol)
		# puts "CREATED (.)(.)   (.)(.)  (.)(.)  (.)(.)  (.)(.) (.)(.)"
	end

	def update_rss(symbols)
      symbols.each do |symbol|
        symbol.gsub!(/\$/, "")
        Article.update_articles(["http://finance.yahoo.com/rss/headline?s=#{symbol}", "http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=#{(symbol.upcase)}"], symbol)
      end
      Article.set_article_sentiments
    end
	end
end

