require 'rails_helper'

describe Tweet do 
	context "in attributes" do
		it "should have text" do
			tweet = Tweet.create(text: "Hello world!")
			expect(tweet.text).to eq("Hello world!")
		end

		it "should have a sentiment" do
			tweet = Tweet.create(sentiment: 0)
			expect(tweet.sentiment).to eq(0)
		end

		it "should have a tweeted_at time" do
			tweet = Tweet.create(tweeted_at: Time.now)
			expect(tweet.tweeted_at).to_not be_nil
		end
	end

	context "associations" do
		it "should be embedded in company" do
			company = Company.create(name: "apple", symbol: "AAPL")
			tweet = Tweet.create(text: "Hello")
			company.tweets << tweet
			expect(tweet.company.name).to eq("apple")
		end
	end
end