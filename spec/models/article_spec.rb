require 'rails_helper'

describe Article, :type => :model do
  let (:company) {Company.create(name:"apple", symbol:"aapl")}
  let (:article) {company.articles.create(url: "http://seekingalpha.com/article/2344175-teslas-real-problem-energy-density", sentiment: 0)}
  context "in attributes" do

    it "should have a url" do
      expect(article.url).to eq("http://seekingalpha.com/article/2344175-teslas-real-problem-energy-density")
    end

    it "should have a sentiment" do
      expect(article.sentiment).to eq(0)
    end
  end

  context "associations" do
    it "should be embedded in company" do
      expect(article.company.name).to eq("apple")
    end
  end

  # context update_articles(2344175-teslas-real-problem-energy-density)
end
