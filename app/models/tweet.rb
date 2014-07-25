class Tweet
  include Mongoid::Document
  field :text, type: String
  field :created_at, type: Time
  field :tweet_id, type: Integer
end
