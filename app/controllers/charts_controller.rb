class ChartsController < ApplicationController
def index

	end

	def chart_data
		puts "params are here: #{params}"
		puts "company is here: #{params[:company]}"

		@quotes = Quote.where(company: params[:company])

		volume = Quote.where(company: 'AAPL').map do |company|
			c=company.c_at.to_i.to_s
			c.gsub!(/[A-Z]{3} /,'')
			c.gsub!(/:Time/,'')
			c+="000"
			[c.to_i, company.volume]
		end

		prices = Quote.where(company: 'AAPL').map do |company|
			c=company.c_at.to_i.to_s
			c.gsub!(/[A-Z]{3} /,'')
			c.gsub!(/:Time/,'')
			c+="000"
			[c.to_i, company.price / 100.0]
		end

		articles = Article.where(company: 'AAPL').map do |article|
			a=article.c_at.to_i.to_s
			a.gsub!(/[A-Z]{3} /,'')
			a.gsub!(/:Time/,'')
			a+="000"
			[a.to_i, article.sentiment]
		end

	 	tweets = Tweet.where(company: 'AAPL').map{ |tweet| [tweet.tweeted_at.strftime('%Q').to_i, tweet.sentiment]}
		puts "tweet #{tweets[0]}"
		puts "price #{prices[0]}"

		render json: {tweets: tweets, volume: volume, prices: prices, articles: articles	}
	end

	def box_data
		avg_daily_expert_sentiment = Article.where(:sentiment.ne => nil).where(:c_at.gt => Time.now - 86400 ).avg(:sentiment).round(2)
		render json: {avg_daily_expert_sentiment: avg_daily_expert_sentiment}
	end

end

# company.price / 100.0
