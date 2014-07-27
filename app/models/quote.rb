class Quote
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  field :volume, type: Integer
  field :price, type: Integer
  field :company, type: String
end
