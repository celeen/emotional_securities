include Sidekiq::Worker
require 'modules/mongoHAL'

namespace :engage do
  desc 'ENGAGE NAIVE BAYES'
  task:hal9000 => :environment do

    storage = Ankusa::MongoDbStorage.new
    hal9000 = Ankusa::NaiveBayesClassifier.new storage

    TweetStream.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY_L']
      config.consumer_secret    = ENV['CONSUMER_SECRET_L']
      config.oauth_token        = ENV['OAUTH_TOKEN_L']
      config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET_L']
      config.auth_method        = :oauth
    end

    experts = [ 303964954, 303964954, 164256304, 38385999, 22026851, 617381538, 400066174, 15003446, 52849759, 1717291, 253167239, 1534167900, 49753604, 182642157, 353737617, 7517052, 8524892, 217284148, 271211220, 47387039, 286654612, 19997064, 244602804, 16295834, 818071, 33216611, 99727393, 600378539 ]
    spam = [22084427,251710903, 25365536, 1534656170, 719065658, 2649728580,900070338, 144130505, 13213122 ]

    learning_targets = experts + spam

    TweetStream::Client.new.follow(learning_targets) do |tweet|
      unless /RT @/.match(tweet.text)
        # Remove @mentions for learner
        text = tweet.text.to_s
        words = text.gsub(/@([a-z0-9_]+)/i, '')
        
        if experts.include?(tweet.user.id)
          hal9000.train :expert, words
        elsif spam.include?(tweet.user.id)
          hal9000.train :spam, words
        end
      end
    end

    storage.close

  end
end
