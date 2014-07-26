class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short #c_at
  field :text, type: String
  field :tweet_id, type: Integer
  field :sentiment, type: Integer
  embedded_in :company
  validates_presence_of :sentiment, :tweeted_at
end
