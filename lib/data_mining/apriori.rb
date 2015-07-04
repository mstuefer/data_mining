module DataMining
  # Apriori Algorithm for frequent set mining and association rule learning
  class Apriori
    # Find frequent item sets
    #
    # Arguments:
    #   transactions: (array of arrays, like [[:id, [transactions]] .. ])
    #   minimum_support: (integer)
    attr_reader :results

    def initialize(transactions, minimum_support)
      @transactions = transactions.select(&:flatten!).each(&:shift)
      @min_support  = minimum_support
      @results      = []
    end

    def mine!
      apriori
    end

    def item_sets_size(size)
      @results[size - 1]
    end

    private

    def apriori
      @results << starting_set
      @results << next_set(@results.last) until @results.last.empty?
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
          arr << candidate if satisfies_min_sup(candidate)
        end
      end
    end

    def possible_candidates(itemset, itemsets)
      itemsets.each_with_object([]) do |set, arr|
        arr << (itemset + [set.last]) if set.last > itemset.last
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
