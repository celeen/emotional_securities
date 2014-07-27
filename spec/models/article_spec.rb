require 'rails_helper'

describe Article, :type => :model do
  let (:article) {Article.create(url: "http://seekingalpha.com/article/2344175-teslas-real-problem-energy-density", sentiment: 0, company: 'aapl')}
  context "in attributes" do

    it "should have a url" do
      expect(article.url).to eq("http://seekingalpha.com/article/2344175-teslas-real-problem-energy-density")
    end

    it "should have a sentiment" do
      expect(article.sentiment).to eq(0)
    end
    it "should have a company" do
      expect(article.company).to eq("aapl")
    end
  end

  context '##retrieve_feed' do
    xit "should do something?" do
    end
  end

  context '##create_articles_from_feed' do
    xit "should do something" do
    end

  context '##update_articles' do
    xit "should also so something probably" do

    end
  end
  end

  # context update_articles(2344175-teslas-real-problem-energy-density)
end
