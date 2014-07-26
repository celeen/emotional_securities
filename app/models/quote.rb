class Quote
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  field :volume, type: Integer
  field :price, type: Integer
  embedded_in :company
end
