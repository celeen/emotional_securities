require 'rails_helper'

describe TweetWorker do
		let(:twerker) {TweetWorker.new}

	context '#get_alchemy_response' do
		# let(:twerker) {TweetWorker.new}
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
		let(:tweet_args) { {text: "Hello world!", tweet_id: 5, tweeted_at: Time.now, company: 'aapl' } }
		it "should add a new tweet to the database" do
		puts "count: #{Tweet.all.count}"
		twerker.create_tweet(tweet_args)
			expect(Tweet.all.count).to eq(1)
		end
	end

	context '#get_stock_quote' do
		let(:quote) { twerker.get_stock_quote }
		
		it "should  instantiate a quote object" do
			expect{twerker.get_stock_quote}.to change{Quote.all.count}
		end

		it "should set a stock price" do
			expect(quote.price).to_not be_nil
		end

		it "should set a stock price as an integer" do
			expect(quote.price).to be_kind_of Integer
		end

		it "should set a volume" do
			expect(quote.volume).to_not be_nil
		end

		it "should set volume as an integer" do
			expect(quote.volume).to be_kind_of Integer
		end
	end

	context '#update_rss' do
		it "should receive the #update_articles message" do
			allow(Article).to receive(:update_articles)
			VCR.use_cassette('update_rss') do
				twerker.update_rss(['tsla'])
				expect(Article).to have_received(:update_articles)
			end
		end
	end

	context '#perform' do
		let(:tweet_args) { {text: "Hello world!", tweet_id: 5, tweeted_at: Time.now, company: 'aapl' } }
		it "should queue jobs" do
			TweetWorker.perform_async(tweet_args, 'tsla', 5001, ['tsla'])
			expect(TweetWorker).to have_enqueued_job(tweet_args, 'tsla', 5001, ['tsla'])
		end

		it "should invoke other methods" do
			TweetWorker.perform_async(tweet_args, 'tsla', 5001, ['tsla'])
			expect(TweetWorker.any_instance).to receive(:get_stock_quote)	
		end
	end
end
