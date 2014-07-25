class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Short #c_at, u_at
  field :text, type: String
  field :tweet_id, type: Integer
end
