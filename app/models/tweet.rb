class Tweet
  include Mongoid::Document
    include Mongoid::Timestamps::Created::Short #c_at
  field :text, type: String
  field :tweet_id, type: Integer  
  field :sentiment, type: Integer
  field :tweeted_at, type: DateTime
  embedded_in :company
<<<<<<< HEAD
=======
  validates_presence_of :tweeted_at
>>>>>>> working on feeding tweets to company
end
