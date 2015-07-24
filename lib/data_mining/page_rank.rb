module DataMining
  # PageRank Algorithm to measure the importance of nodes in a graph
  class PageRank
    attr_reader :graph, :ranks
    # Measure importance of nodes
    #
    # Arguments:
    #   graph: (array of arrays, like:
    #     [[:p1, [:p2]], [:p2, [:p1, :p3]], [:p3, [:p2]]]
    #   damping_factor: (double between 0 and 1)
    def initialize(graph, damping_factor = 0.85, iterations = 100)
      @graph      = graph.to_h
      # { :p1 => [:p2], :p2 => [:p1,:p3], :p3 => [:p2] }
      @outlinks   = Hash.new { |_, key| @graph[key].size }
      # { :p1 => 1, :p2 => 2, :p3 => 1 }
      @inlinks    = Hash.new { |_, key| inlinks(key) }
      # { :p1 => [:p2], :p2 => [:p1,:p3], :p3 => [:p2] }
      @ranks      = Hash.new(1.0 / @graph.size)
      # { :p1 => 1/3, :p2 => 1/3, ... }
      @sinknodes  = @graph.select { |_, v| v.empty? }.keys
      # sinknodes aka dead-ends, have no outlink at all

      @damper     = damping_factor
      @iterations = iterations
    end

    def rank!
      pagerank
    end

    private

    def inlinks(key)
      @graph.select { |_, v| v.include?(key) }.keys
    end

    def pagerank
      @iterations.times { @ranks = next_state }
    end

    def next_state
      current_term = term
      @graph.each_with_object({}) do |(node, _), ranks|
        ranks[node] = current_term + @damper * sum_incoming_scores(node)
      end
    end

    def sum_incoming_scores(node)
      @inlinks[node].map { |id| @ranks[id] / @outlinks[id] }.inject(:+).to_f
    end

    def term
      ((1 - @damper + @damper * pagerank_of_sinknodes) / @graph.size)
    end

    def pagerank_of_sinknodes
      return 0 if @sinknodes.empty?
      @ranks.select { |k, _| @sinknodes.include?(k) }.values.inject(:+).to_f
    end
  end
end
