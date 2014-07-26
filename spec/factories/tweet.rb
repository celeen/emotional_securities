FactoryGirl.define do
  factory :tweet do
    text "Hello world!"
    tweet_id 5
    sentiment 0.12
    tweeted_at Time.now
    
	end   
end