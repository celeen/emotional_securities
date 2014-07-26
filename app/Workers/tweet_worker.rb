require 'alchemiapi'

class TweetWorker
	include Sidekiq::Worker 

	def perform(tweet_id)
		alchemyapi = AlchemyAPI.new
		puts alchemyapi
		tweet = Tweet.find(tweet_id)
		response = alchemyapi.sentiment('text', tweet.text)		
	end
end	