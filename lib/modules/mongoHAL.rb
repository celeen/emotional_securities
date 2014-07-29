module Ankusa
  class MongoDbStorage

    def initialize(opts={})

      @db = Mongoid::Sessions.default

      @ftablename = "word_frequencies"
      @stablename = "summary"

      @klass_word_counts = {}
      @klass_doc_counts = {}

      # init_tables
    end


    def init_tables
      # MONGOID INITS FOR US 
    end

    def classnames
      Summary.distinct('klass')
    end

    def incr_word_count(klass, word, count)
     our_word = WordFrequency.find_or_create_by(word: word)
     our_word.inc(klass => count)
     our_word.upsert

      #update vocabulary size
      word_doc = WordFrequency.find_by(:word => word)
      if word_doc[klass.to_s] == count
        increment_summary_klass(klass, 'vocabulary_size', 1)
      elsif word_doc[klass.to_s] == 0
        increment_summary_klass(klass, 'vocabulary_size', -1)
      end
      word_doc[klass.to_s]
    end

    def incr_total_word_count(klass, count)
      increment_summary_klass(klass, 'word_count', count)
    end

    def incr_doc_count(klass, count)
      increment_summary_klass(klass, 'doc_count', count)
    end

    def get_word_counts(word)
      counts = Hash.new(0)

      word_doc = WordFrequency.find_by(:word => word)
      if word_doc
        word_doc.delete("_id")
        word_doc.delete("word")
        #convert keys to symbols
        counts.merge!(word_doc.inject({}){|h, (k, v)| h[(k.to_sym rescue k) || k] = v; h}) 
      end

      counts
    end

    def get_total_word_count(klass)
      klass_doc = Summary.find_by(:klass => klass)
      klass_doc ? klass_doc['word_count'].to_f : 0.0
    end

    def doc_count_totals
      count = Hash.new(0)

      Summary.find.each do |doc|
        count[ doc['klass'] ] = doc['doc_count']
      end

      count
    end

    def get_vocabulary_sizes
      count = Hash.new(0)

      Summary.find.each do |doc|
        count[ doc['klass'] ] = doc['vocabulary_size']
      end

      count
    end

    def get_doc_count(klass)
      klass_doc = Summary.find_by(:klass => klass) 
      klass_doc ? klass_doc['doc_count'].to_f : 0.0
    end

    def close
    end

    def increment_summary_klass(klass, field, count)
      our_summary = Summary.find_or_create_by(klass: klass)
      our_summary.inc(field => count)
      our_summary.upsert
    end

  end
end