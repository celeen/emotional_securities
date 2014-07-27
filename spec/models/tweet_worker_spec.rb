require 'rails_helper'

describe TweetWorker do
	context '#perform' do 
		xit "should accept a tweet_id" do
			tweet = Tweet.create(text: "Hello World", tweet_id: 5, created_at: Time.now)
			puts "this is the sentiment: #{tweet.sentiment}"
			TweetWorker.perform_async(5)
			expect(tweet.sentiment).to_not be_nil
		end
	end

	context '#get_alchemy_response' do
		let(:twerker) {TweetWorker.new}
		it "should return something" do
			expect(twerker.get_alchemy_response("What a beautiful day!")).to_not be_nil
		end

		it "should return a float" do
			expect(twerker.get_alchemy_response("What a beautiful day!")).to be_kind_of Float
		end
	end

	context '#create_tweet' do
		let(:twerker) {TweetWorker.new}
		let(:tweet_args) { {text: "Hello world!", tweet_id: 5, tweeted_at: Time.now, company: 'aapl' } }
		it "should add a new tweet to the database" do
		puts "count: #{Tweet.all.count}"
		twerker.create_tweet(tweet_args)
		puts "count: #{apple.tweets.count}"
			expect(Tweet.all.count).to eq(1)		
		end
	end
end