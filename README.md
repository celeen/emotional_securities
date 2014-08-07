
#Emotional Securities

[![Build Status](https://travis-ci.org/celeen/emotional_securities.svg?branch=master)](https://travis-ci.org/celeen/emotional_securities)
[![Coverage Status](https://img.shields.io/coveralls/celeen/emotional_securities.svg)](https://coveralls.io/r/celeen/emotional_securities)

note: Build is failing on travis right now because of configuration errors within the travis environment. a fix for this is in progress.

Emotional Securities is an experimental sentiment analysis tool for the stock market.

Working off a few of the core metrics of behavioral finance, we pulled "herd" sentiment data from the [Twitter Streaming API](https://dev.twitter.com/), and "expert" sentiment from articles on [Yahoo Finance](http://finance.yahoo.com/"). [AlchemyAPI](http://www.alchemyapi.com/) kindly granted us academic access to [their amazing service](http://www.alchemyapi.com/products/products-overview/), which we used to analyze sentiment in tweets, and entity targeted sentiment in articles.

We have incorporated a [Naïve Bayes](http://en.wikipedia.org/wiki/Naive_Bayes_classifier) [implementation](https://github.com/bmuller/ankusa) to sort out irrelevant tweets; our algorithm, fondly nicknamed Hal9000, is given a sampling of "expert" tweets, and non-related tweets. It learns what words and phrases are commonly used in the relevant tweets, and sorts our incoming stream based on that data.

The graph in the main view plots, in line form, stock price over time and an exponential moving average of tweet sentiments, which can be seen in a scatterplot behind the two main lines.
