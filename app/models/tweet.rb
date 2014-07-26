class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Short #c_at, u_at
  field :text, type: String
  field :tweet_id, type: Integer
  field :sentiment, type: Integer
  field :tweeted_at, type: DateTime
  embedded_in :company
  validates_presence_of :sentiment, :tweeted_at
end
