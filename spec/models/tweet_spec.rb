require 'rails_helper'

describe Tweet do 
	context "in attributes" do
		# let(:apple) {Company.create(symbol: 'aapl', name: "Apple")}
		let(:tweet) {Tweet.create(text: "Hello world!", sentiment: 0.1, tweeted_at: Time.now, company: 'aapl')}
		it "should have text" do
			expect(tweet.text).to eq("Hello world!")
		end

		it "should have a sentiment" do
			tweet = Tweet.create(sentiment: 0)
			expect(tweet.sentiment).to eq(0)
		end

		it "should have a tweeted_at time" do
			expect(tweet.tweeted_at).to_not be_nil
		end
		it "should be embedded in company" do
			expect(tweet.company).to eq("aapl")
		end
	end
end