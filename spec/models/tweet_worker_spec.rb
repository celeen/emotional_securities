require 'rails_helper'

describe TweetWorker do
		xit "puts a job in queue" do
			subject.perform

			expect(TweetWorker).to have_enqueued_job
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
			expect(Tweet.all.count).to eq(1)
		end
	end
end
