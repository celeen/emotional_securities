require 'alchemiapi'

class Article
  include Mongoid::Document
  field :url, type: String
  field :sentiment, type: Float
  field :company, type: String
  field :c_at, type: DateTime

  validates_uniqueness_of :url
  validates_presence_of :url

  def self.retrieve_feed(urls)
    @feeds = Feedjira::Feed.fetch_and_parse urls
  end

  def self.create_articles_from_feed(urls, company_symbol)
    urls.each do |url|
      @feeds[url].entries.map{|article|Article.create(url: article.url.gsub(/http\:\/\/us\.rd\.yahoo\.com\/finance\/news\/rss\/story\/\*/, ""), company: company_symbol, c_at: article.published)}
    end
  end

  def get_company_name(stock_symbol)
    puts "in get company name"
    name = StockQuote::Stock.quote(stock_symbol).name
    name.gsub!(/(\A\w+)(.+)/, '\1')
    p name
  end

  def self.set_article_sentiments
    alchemyapi = AlchemyAPI.new
    articles = Article.all.reject do |article|
      article.sentiment
    end

    puts "These are the articles returned: #{articles}"

    articles.map do |article|
      response = alchemyapi.sentiment_targeted('url', article.url, article.get_company_name(article.company))
      article.sentiment = response['docSentiment']['score']
      article.save
    end
  end

  def self.update_articles(urls, company_symbol)
    Article.retrieve_feed(urls)
    Article.create_articles_from_feed(urls, company_symbol)
  end

end

# try taking out everything before *
# get rid of noodls
