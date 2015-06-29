module DataMining
  # Apriori Algorithm for frequent set mining and association rule learning
  class Apriori
    attr_reader :results

    def initialize(transactions, minimum_support)
      @transactions = transactions.select(&:flatten!).each(&:shift)
      @min_support  = minimum_support
      @results      = {}
    end

    def mine!
      apriori
    end

    private

    def apriori
      tmp = starting_set
      i   = 1
      while tmp.size > 0
        @results[i] = tmp
        i += 1
        tmp = next_set(tmp)
      end
    end

    def starting_set
      frequent_items.reject { |_, v| v < @min_support }.keys.sort.map { |i| [i] }
    end

    def frequent_items
      @transactions.each_with_object(Hash.new(0)) do |sets, hash|
        sets.each { |item| hash[item] += 1 }
      end
    end

    def next_set(itemsets)
      itemsets.each_with_object([]) do |set, arr|
        possible_candidates(set, itemsets).each do |candidate|
          arr.push(candidate) if satisfies_min_sup(candidate)
        end
      end
    end

    def possible_candidates(itemset, itemsets)
      itemsets.each_with_object([]) do |set, arr|
        arr.push(itemset + [set.last]) if set.last > itemset.last
      end.uniq
    end

    def satisfies_min_sup(candidate)
      return true if (@transactions.inject(0) do |counter, entry|
        counter += 1 if (candidate - entry).empty?
        counter
      end >= @min_support)
      false
    end
  end
end
