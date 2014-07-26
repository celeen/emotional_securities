class Company
  include Mongoid::Document
  field :symbol, type: String
  field :name, type: String
  embeds_many :quotes
  embeds_many :tweets
  validates_presence_of :symbol
  validates_uniqueness_of :symbol
end
