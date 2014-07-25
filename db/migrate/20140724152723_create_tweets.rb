class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :link_id
      t.integer :sent_id
      t.datetime :tweet_time

      t.timestamps
    end
  end
end
