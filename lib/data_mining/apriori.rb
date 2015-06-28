module DataMining
  # Apriori Algorithm for frequent set mining and association rule learning
  class Apriori
    attr_reader :results

    def initialize(transactions, minimum_support)
      @transactions = transactions.select { |t| t.flatten! }.each { |t| t.delete_at(0) }
      @min_support  = minimum_support
      @results      = {}
    end

    def mine!
      apriori
    end

    private

    def apriori
      tmp, i = starting_set, 1
      while tmp.size > 0 do
        @results[i] = tmp
        i += 1
        tmp = next_set(tmp)
      end
    end

    def starting_set
      @transactions.inject(Hash.new(0)) do |hash, sets|
        sets.each { |item| hash[item] += 1 }
        hash
      end.reject { |k, v| v < @min_support}.keys.sort.map { |i| [i] }
    end

    def next_set(itemsets)
      arr = []
      for set in itemsets
        for candidate in possible_candidates(set, itemsets)
          arr.push(candidate) if satisfies_min_sup(candidate)
        end
      end
      arr
    end

    def possible_candidates(itemset, itemsets)
      arr = []
      for set in itemsets
        arr.push(itemset+[set.last]) if set.last > itemset.last
      end
      arr.uniq
    end

    def satisfies_min_sup(candidate)
      return true if( @transactions.inject(0) do |counter,entry|
        counter += 1 if (candidate - entry).empty?
        counter
      end >= @min_support)
      false
    end
  end
end
