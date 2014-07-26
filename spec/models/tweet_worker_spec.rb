require 'rails_helper'

describe 'TweetWorker'
	context '#perform' do 
	let(:tweet_worker) { TweetWorker.new }
		it "should accept a tweet_id" do
			tweet_worker()
		end

		xit "should find a tweet object" do
		end

		xit "should instantiate a new AlchemyAPI connection" do
		end

		xit "should return a response from the AlchemyAPI" do
		end

		it "should return a tweet object that has a sentiment value" do
		end
	end