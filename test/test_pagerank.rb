require 'test_helper'

class DataMining::PageRankTest < MiniTest::Test
  def setup
    @graph = []
    @graph << [:a, [:b]]
    @graph << [:b, [:a, :c]]
    @graph << [:c, [:b]]

    @result = DataMining::PageRank.new(@graph)
    @result.rank!

    @rank   = {a: 0.2567567634554257, b: 0.4864864730891484, c: 0.2567567634554257}
  end

  def test_correct_size
    assert_equal 3, @result.graph.size
    assert_equal @rank, @result.ranks
  end

  def test_sum_to_one
    assert_equal 1, @result.ranks.values.inject(:+).round
  end
end
