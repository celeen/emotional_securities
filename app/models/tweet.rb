class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short #c_at
  field :text, type: String
  field :tweet_id, type: Integer
  field :sentiment, type: Float
  field :tweeted_at, type: DateTime
  field :company, type: String



  def running_avg(company, limit)
  	# ordered = Tweet.where(company: company).order{:tweeted_at}
  	# ordered.map { |tweet| }
  	# .limit(limit).avg(:sentiment)

  	# array[tweet.postion...tweet.position+10]
  	# avg = 0.0
  	# count = 0

  	# lamda do |x| 
  	# 	count += 1
  	# 	avg += (x - avg) / count
  	# end

  end
end

# in controller dataPoints.map { |point| point.running_10 }
