class ChartsController < ApplicationController

	ONE_DAY = 86400

  def index

  end

  def chart_data

    # @quotes = Quote.where(company: params[:company]).order{:c_at}.where(:c_at.gt => Time.now - ONE_DAY)

    # volume = Quote.where(company: params[:company]).order{:c_at}.map do |company|
    #   c=company.c_at.to_i.to_s
    #   c.gsub!(/[A-Z]{3} /,'')
    #   c.gsub!(/:Time/,'')
    #   c+="000"
    #   [c.to_i, company.volume]
    # end

    prices = Quote.where(company: params[:company]).order{:c_at}.where(:c_at.gt => Time.now - ONE_DAY).map do |company|
      c=company.c_at.to_i.to_s
      c.gsub!(/[A-Z]{3} /,'')
      c.gsub!(/:Time/,'')
      c+="000"
      [c.to_i, company.price / 100.0]
    end

    articles = Article.where(company: params[:company], :sentiment.ne => nil).order{:c_at}.map do |article|

      a=article.c_at.to_i.to_s
      a.gsub!(/[A-Z]{3} /,'')
      a.gsub!(/:Time/,'')
      a+="000"
      [a.to_i, article.sentiment]
    end.sort_by {|array| array[0]}

    tweets = Tweet.where(company: params[:company]).order{:tweeted_at}.where(:tweeted_at.gt => Time.now - ONE_DAY).map{ |tweet| [tweet.tweeted_at.strftime('%Q').to_i, tweet.sentiment]}

    render json: {tweets: tweets, prices: prices, articles: articles	}
  end

  def expert_data
    company = params[:company]

    @daily_articles = Article.where(company: company).where(:sentiment.ne => nil).where(:c_at.gt => Time.now - ONE_DAY )


    avg_daily_expert_sentiment = @daily_articles.avg(:sentiment).round(2) unless @daily_articles.count == 0

    exp_values = @daily_articles.to_a
    feelings = exp_values.map { |article| article.sentiment }

    exp_value_quotes = Quote.where(company: company).sort({_id:1}).limit(exp_values.length).to_a

    prices = exp_value_quotes.map { |quote| quote.price }

    pearson = Statsample::Bivariate::Pearson.new(feelings.to_scale, prices.to_scale)

    render json: { avg_daily_expert_sentiment: avg_daily_expert_sentiment, correlation: pearson.r }
  end

  def herd_data
    company = params[:company]

    @daily_tweets = Tweet.where(company: company).where(:sentiment.ne => nil).where(:tweeted_at.gt => Time.now - ONE_DAY)

    avg_daily_herd_sentiment = @daily_tweets.avg(:sentiment).round(2)

    herd_values = @daily_tweets.to_a

    feelings = herd_values.map { |article| article.sentiment }

    herd_value_quotes = Quote.where(company: company).sort({_id:1}).limit(herd_values.length).to_a

    prices = herd_value_quotes.map { |quote| quote.price }

    pearson = Statsample::Bivariate::Pearson.new(feelings.to_scale, prices.to_scale)

    render json: { avg_daily_herd_sentiment: avg_daily_herd_sentiment, correlation: pearson.r }
  end

  def volume_data
    company = params[:company]

    first_daily_quote = Quote.first_quote_24(company)
    last_quote = Quote.where(company: company).last

    daily_volume_delta = first_daily_quote.volume - last_quote.volume

    render json: { daily_volume_delta: daily_volume_delta }
  end

end
