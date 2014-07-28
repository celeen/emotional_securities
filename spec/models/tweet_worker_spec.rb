require 'rails_helper'

describe TweetWorker do
		xit "puts a job in queue" do
			subject.perform

			expect(TweetWorker).to have_enqueued_job
		end


	context '#get_alchemy_response' do
		let(:twerker) {TweetWorker.new}
		it "should return something" do
			VCR.use_cassette('twerker') do
				response = twerker.get_alchemy_response("What a beautiful day!")
				expect(response).to_not be_nil
			end
		end

		it "should return a float" do
			VCR.use_cassette('twerker_float') do
				response = twerker.get_alchemy_response("What a beautiful day!")
				expect(response).to be_kind_of Float
			end
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
