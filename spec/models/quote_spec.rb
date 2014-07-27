require 'rails_helper'

describe Quote, :type => :model do
  context 'attributes' do
  	let(:quote) { Quote.create(price: 97, volume: 2, company: 'aapl')}
  	it { should respond_to :price }
  	it { should respond_to :volume }
  	it { should respond_to :company }
  end
end
