require 'test_helper'

class DataMining::PageRankTest < MiniTest::Test
  def setup
    @graph = []
    @graph << [:a, [:b]]
    @graph << [:b, [:a, :c]]
    @graph << [:c, [:b]]

    @graph2 = []
    @graph2 << [:a, []]
    @graph2 << [:b, [:c]]
    @graph2 << [:c, [:b]]
    @graph2 << [:d, [:a, :b]]
    @graph2 << [:e, [:d, :e, :f]]
    @graph2 << [:f, [:b, :e]]
    @graph2 << [:g, [:b, :e]]
    @graph2 << [:h, [:b, :e]]
    @graph2 << [:i, [:b, :e]]
    @graph2 << [:j, [:e]]
    @graph2 << [:k, [:e]]

    @graph3 = []
    @graph3 << [:a, [:b]]
    @graph3 << [:b, []]

    @result = []
    @result << DataMining::PageRank.new(@graph)
    @result << DataMining::PageRank.new(@graph2, 0.85, 100)
    @result << DataMining::PageRank.new(@graph3)
    @result.each(&:rank!)

    @rank1  = {a: 0.2567567634554257, b: 0.4864864730891484, c: 0.2567567634554257}
    @rank2  = {a: 0.038417447881941, b: 0.34419999505993143, c: 0.30917500459052033, d: 0.05132344299501629, e: 0.12253573547984897, f: 0.05132344299501629, g: 0.01660498460905908, h: 0.01660498460905908, i: 0.01660498460905908, j: 0.01660498460905908, k: 0.01660498460905908}
    @rank3  = {a: 0.3508771784030001, b: 0.6491227778586317}

  end

  def test_correct_size
    assert_equal 3, @result[0].graph.size
    assert_equal 2, @result[2].graph.size
  end

  def test_correct_result
    assert_equal @rank1, @result[0].ranks
    assert_equal @rank2, @result[1].ranks
    assert_equal @rank3, @result[2].ranks
  end

  def test_sum_to_one
    assert ((1 - @result[0].ranks.values.inject(:+)) < 0.001)
    assert ((1 - @result[1].ranks.values.inject(:+)) < 0.001)
    assert ((1 - @result[2].ranks.values.inject(:+)) < 0.001)
  end
end
