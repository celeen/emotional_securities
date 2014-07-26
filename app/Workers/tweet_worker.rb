require 'alchemiapi'

class TweetWorker
	include Sidekiq::Worker 

	def perform(tweet_args)
		puts "args in perform: #{args}"
		puts "response from alchemy is: #{response}"

		tweet_args[:sentiment] = get_alchemy_response(tweet_args[:text])

		create_tweet(tweet_args)	
	end

	def get_alchemy_response(text)
		response = (AlchemyAPI.new).sentiment('text', text)
		response['docSentiment']['score'].to_f
	end

	def create_tweet(tweet_args)
		apple = Company.find_by(symbol: 'aapl')
		apple.tweets.create(tweet_args)
	end
end	