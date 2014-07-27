class Article
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short #c_at
  field :url, type: String
  field :sentiment, type: Integer
  validates_uniqueness_of :url
  validates_presence_of :url
  embedded_in :company

  def self.retrieve_feed(urls)
    @feeds = Feedjira::Feed.fetch_and_parse urls
  end

  def self.create_articles_from_feed(urls, company_symbol)
    urls.each do |url|
      @feeds[url].entries.map{|article|Article.create(url: article.url, company: company_symbol, published_at: article.published)}
    end
  end

  def self.update_articles(urls, company_symbol)
    Article.retrieve_feed(urls)
    Article.create_articles_from_feed(urls, company_symbol)
  end





  # def self.update_feeds(urls)
  #   urls.each do |url|
  #    Feedjira::Feed.update(Article.create_feeds(urls)[url]).new_entries
  #   end
  # end
end
