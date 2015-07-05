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

    @result = []
    @result << DataMining::PageRank.new(@graph)
    @result << DataMining::PageRank.new(@graph2)
    @result.each(&:rank!)

    @rank1  = {a: 0.2567567634554257, b: 0.4864864730891484, c: 0.2567567634554257}
    @rank2  = {a: 0.0315492186011054, b: 0.28266429869980386, c: 0.2539010402240255, d: 0.042147894034686495, e: 0.10062893081761008, f: 0.042147894034686495, g: 0.01363636363636364, h: 0.01363636363636364, i: 0.01363636363636364, j: 0.01363636363636364, k: 0.01363636363636364}
  end

  def test_correct_size
    assert_equal 3, @result[0].graph.size
  end

  def test_correct_result
    assert_equal @rank1, @result[0].ranks
    assert_equal @rank2, @result[1].ranks
  end

  def test_sum_to_one
    assert_equal 1, @result[0].ranks.values.inject(:+).round
    assert_equal 1, @result[1].ranks.values.inject(:+).round
  end
end
