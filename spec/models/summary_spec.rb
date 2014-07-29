require 'rails_helper'

describe Summary, :type => :model do

	context "has attributes" do 
		let(:exp_summary) { Summary.create(expert: 3) }
		let(:spam_summary) { Summary.create(spam: 2) }

		it "should have an expert summary" do
			expect(exp_summary.expert).to eq(3)
		end

		it "should have a spam summary" do
			expect(spam_summary.spam).to eq(2)
		end
	end

	context "increment with each word appearance" do 
	end

end
