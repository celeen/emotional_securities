require 'rails_helper'

describe 'POST Methods' do
	before :each do
		visit root
	end

	scenario 'grab the expert sentiment' do
		response.body.should include("")
	end

	scenario 'grab the herd sentiment' do
		response.body.should include("")
	end

	scenario 'grab the volume data' do
		response.body.should include("")
	end
end
