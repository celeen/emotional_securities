class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short #c_at
  field :text, type: String
  field :tweet_id, type: Integer
  field :sentiment, type: Float
  field :tweeted_at, type: DateTime
  field :company, type: String
end
