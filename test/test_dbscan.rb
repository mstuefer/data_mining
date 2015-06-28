require 'test_helper'

class DataMining::DBScanTest < MiniTest::Test
  def setup
    @input      = []
    @input << [[:p1, [1]], [:p2, [2]], [:p3, [10]], [:p4, [12]]]
    @input << [[:p1, [1]], [:p2, [2]], [:p3, [10]]]
    @input << [[:p1, [1, 1]], [:p2, [2, 2]], [:p3, [1, 2]], [:p4, [9, 9]]]

    @radius     = 2
    @min_points = 2

    @input.map! { |i| DataMining::DBScan.new(i, @radius, @min_points) }
    @input.map(&:cluster!)
  end

  def test_correct_amount_of_clusters_found
    assert_equal 2, @input[0].clusters.size
    assert_equal 1, @input[1].clusters.size
    assert_equal 1, @input[2].clusters.size
  end

  def test_correct_amount_of_outliers_found
    assert_equal 0, @input[0].outliers.size
    assert_equal 1, @input[1].outliers.size
    assert_equal 1, @input[2].outliers.size
  end

  def test_correct_point_outlier
    assert_equal :p3, @input[1].outliers.first.id
    assert_equal :p4, @input[2].outliers.first.id
  end
end
