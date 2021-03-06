require 'rails_helper'

describe Article, :type => :model do
  let (:article) {Article.create(url: "http://www.fool.com/investing/general/2014/07/27/tesla-motors-inc-delivers-first-cars-to-hong-kong.aspx", sentiment: 0, company: 'tsla', c_at: Time.now)}
  context "in attributes" do

    it "should have a url" do
      expect(article.url).to eq("http://www.fool.com/investing/general/2014/07/27/tesla-motors-inc-delivers-first-cars-to-hong-kong.aspx")
    end
    it "should have a sentiment" do
      expect(article.sentiment).to eq(0)
    end
    it "should have a company" do
      expect(article.company).to eq("tsla")
    end
    it "should have a created_at field" do
      expect(article.c_at).to_not be_nil
    end
  end

  context '##retrieve_feed' do
    it "should return a feed" do
      expect(Article.retrieve_feed(["http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=EWJ"])).to_not be_nil
    end
  end

  context '##create_articles_from_feed' do
    it "should create articles from a feed" do
      Article.retrieve_feed(["http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=EWJ"])
      Article.create_articles_from_feed(["http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=EWJ"], "ewj")
      expect(Article.where(company: "ewj").length).to be > 0
    end
  end

  context '##update_articles' do
    it "should also so something probably" do
    VCR.use_cassette('update_articles') do
      Article.update_articles(["http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=TSLA"], "tsla")
    end
      expect(Article.where(company: "tsla").length).to be > 0
    end
  end

  context '##set_article_sentiments' do
    it 'should update  sentiment' do
      article = Article.create(url: 'http://www.fool.com/investing/general/2014/07/27/tesla-motors-inc-delivers-first-cars-to-hong-kong.aspx', company: 'tsla', c_at: Time.now)
      error_article = Article.create()
      VCR.use_cassette('sentiments') do
        Article.set_article_sentiments
      end
      expect(article.reload.sentiment).to_not be_nil
    end
    it 'should score neutral articles as 0' do
      neutral_article = Article.create(url: "http://www.nasdaq.com/article/automakers-dominate-green-brands-list-ford-tops-analyst-blog-cm365329", company: "HMC")
      VCR.use_cassette('neutral_example') do
        Article.set_article_sentiments
      end
      expect(neutral_article.reload.sentiment).to eq(0)
    end
    it 'should flag articles without enough information' do
      error_article = Article.create(url: "http://www.marketwatch.com/story/the-market-in-a-minute-what-will-gdp-mean-for-the-market-2014-07-28?siteid=yhoof2", company: "TSN")
      VCR.use_cassette('error_example') do
        Article.set_article_sentiments
      end
      expect(error_article.reload.flag).to be true
    end
  end
end
