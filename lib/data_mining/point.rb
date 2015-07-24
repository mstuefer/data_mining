module DataMining
  # Point class
  class Point
    attr_reader :id, :value

    # Represents a Point
    #
    # Arguments:
    #   id: (symbol)
    #   value: (array)

    def initialize(id, value)
      @id             = id
      @value          = value
      @visited        = false
      @in_a_cluster   = false
    end

    def assigned_to_cluster?
      @in_a_cluster
    end

    def assign_to_cluster!
      @in_a_cluster = true
    end

    def visited?
      @visited
    end

    def visit!
      @visited = true
    end
  end
end
