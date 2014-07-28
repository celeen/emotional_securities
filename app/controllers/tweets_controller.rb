class TweetsController < ApplicationController

	def index

	end

	def chart_data

		@quotes = Quote.where(company: 'AAPL')

		volume = @quotes.map { |company| company.volume}

		prices = @quotes.map { |company| company.price / 100.0 }

		@tweets = Tweet.where(company: 'AAPL')

		sentiments = @tweets.map{ |tweet| tweet.sentiment }

		dates = @tweets.map{ |tweet| tweet.tweeted_at.strftime('%Q').to_i }

		render json: {volume: volume, prices: prices, tweetSentiments: sentiments, dates: dates}
	end

	def box_data
		Article.where(:sentiment.ne => nil).where(:c_at.gt => Time.now - 86400 ).avg(:sentiment)
	end
end
