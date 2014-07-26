require 'rails_helper'

describe Tweet do 
	context '#create' do
		it "should instantiate with a tweet_created datetime" do
			tweet = Tweet.create(text: "Hey there", tweet_id: 5, created_at: Time.now)
			expect(tweet.created_at).to_not be_nil
		end
	end
end