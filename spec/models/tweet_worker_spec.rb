require 'rails_helper'

describe 'TweetWorker'
	context '#perform' do 
		xit "should accept a tweet_id" do
			tweet = Tweet.create(text: "Hello World", tweet_id: 5, created_at: Time.now)
			puts "this is the sentiment: #{tweet.sentiment}"
			TweetWorker.perform_async(5)
			expect(tweet.sentiment).to_not be_nil
		end
	end

	context '#get_alchemy_response' do
		it "should return a numerical value" do
			expect(get_alchemy_response("What a beautiful day!")).to exist
		end
	end