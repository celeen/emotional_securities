class Quote
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  field :volume, type: Integer
  field :price, type: Integer
  field :company, type: String


  def self.first_quote_24(company)
  	where(company: company).where(:c_at.gt => Time.now - 86400).first
  end

end
