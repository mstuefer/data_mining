require 'minitest/autorun'
require 'data_mining'

class DataMining::DBScanTest < MiniTest::Test
  def setup
    # one dimension
    @input_1    = [[:p1, [1]], [:p2, [2]], [:p3, [10]], [:p4, [12]]]
    @input_2    = [[:p1, [1]], [:p2, [2]], [:p3, [10]]]
    # two dimension
    @input_3    = [[:p1, [1,1]], [:p2, [2,2]], [:p3, [1,2]], [:p4, [9,9]]]

    @radius     = 2
    @min_points = 2

    @dbscan1    = DataMining::DBScan.cluster(@input_1, @radius, @min_points)
    @dbscan1.build!

    @dbscan2    = DataMining::DBScan.cluster(@input_2, @radius, @min_points)
    @dbscan2.build!

    @dbscan3    = DataMining::DBScan.cluster(@input_3, @radius, @min_points)
    @dbscan3.build!
  end

  def test_correct_amount_of_clusters_found
    assert_equal 2, @dbscan1.clusters.size
    assert_equal 1, @dbscan2.clusters.size
    assert_equal 1, @dbscan3.clusters.size
  end

  def test_correct_amount_of_outliers_found
    assert_equal 0, @dbscan1.outliers.size
    assert_equal 1, @dbscan2.outliers.size
    assert_equal 1, @dbscan3.outliers.size
  end

  def test_correct_point_outlier
    assert_equal :p3, @dbscan2.outliers.first.id
    assert_equal :p4, @dbscan3.outliers.first.id
  end
end
