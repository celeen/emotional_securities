class TweetWorker
	include Sidekiq::Worker 

	def perform(tweet_id)
		puts 'Doing Hardwork'
	end
end	