require 'minitest/autorun'
require 'data_mining'

class DataMining::DBScanTest < MiniTest::Test
  def setup
    @input_1    = [[:p1, 1], [:p2, 2], [:p3, 10], [:p4, 12]]
    @input_2    = [[:p1, 1], [:p2, 2], [:p3, 10]]
    @radius     = 2
    @min_points = 2

    @dbscan1    = DataMining::DBScan.cluster(@input_1, @radius, @min_points)
    @dbscan1.build!

    @dbscan2    = DataMining::DBScan.cluster(@input_2, @radius, @min_points)
    @dbscan2.build!
  end

  def test_correct_amount_of_clusters_found
    assert_equal 2, @dbscan1.clusters.size
  end

  def test_no_outliers
    assert_equal 0, @dbscan1.outliers.size
  end

  def test_correct_amount_of_outliers
    assert_equal 1, @dbscan2.outliers.size
  end

  def test_correct_point_outlier
    assert_equal :p3, @dbscan2.outliers.first.id
  end
end
