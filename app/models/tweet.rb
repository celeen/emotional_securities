class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short #c_at
  field :text, type: String
  field :tweet_id, type: Integer
  field :sentiment, type: Float
  field :tweeted_at, type: DateTime
  field :company, type: String


  def avg
    self.inject{ |sum, n| sum + n.sentiment }/self.length
  end

end

