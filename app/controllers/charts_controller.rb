class ChartsController < ApplicationController
def index

	end

	def chart_data
		puts "params are here: #{params}"
		puts "company is here: #{params[:company]}"

		@quotes = Quote.where(company: params[:company])

		volume = @quotes.map { |company| company.volume}

		prices = @quotes.map { |company| company.price / 100.0 }

		@tweets = Tweet.where(company: params[:company])

		sentiments = @tweets.map{ |tweet| tweet.sentiment }

		dates = @tweets.map{ |tweet| tweet.tweeted_at.strftime('%Q').to_i }

		render json: {volume: volume, prices: prices, tweetSentiments: sentiments, dates: dates}
	end

	def box_data
		avg_daily_expert_sentiment = Article.where(:sentiment.ne => nil).where(:c_at.gt => Time.now - 86400 ).avg(:sentiment).round(2)
		render json: {avg_daily_expert_sentiment: avg_daily_expert_sentiment}
	end
	
end
