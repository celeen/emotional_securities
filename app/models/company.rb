class Company
  include Mongoid::Document
  field :symbol, type: String
  field :name, type: String
  embeds_many :quotes
  embeds_many :tweets
end
