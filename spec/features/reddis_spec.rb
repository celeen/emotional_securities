require 'rails_helper'

describe 'Redis connection' do
	Sidekiq::Testing.fake!

	it 'should be able to perform async' do
		expect {TweetWorker}
	end
end

