require 'rails_helper'

describe Tweet do 
	context "in attributes" do
		let(:apple) {Company.create(symbol: 'aapl', name: "Apple")}
		it "should have text" do
			tweet = apple.tweets.create(text: "Hello world!")
			expect(tweet.text).to eq("Hello world!")
		end

		it "should have a sentiment" do
			tweet = apple.tweets.create(sentiment: 0)
			expect(tweet.sentiment).to eq(0)
		end

		it "should have a tweeted_at time" do
			tweet = apple.tweets.create(tweeted_at: Time.now)
			expect(tweet.tweeted_at).to_not be_nil
		end
	end

	context "associations" do
		let(:apple) {Company.create(symbol: 'aapl', name: "Apple")}
		it "should be embedded in company" do
			company = Company.create(name: "apple", symbol: "AAPL")
			tweet = apple.tweets.create(text: "Hello")
			expect(tweet.company.name).to eq("Apple")
		end
	end
end