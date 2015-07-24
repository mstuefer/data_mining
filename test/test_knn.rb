require 'test_helper'

class DataMining::KNearestNeighborTest < MiniTest::Test
  def setup
    @training_sets = []
    @training_sets << [[:c1, [1]], [:c1, [2]], [:c2, [10]], [:c2, [13]]]
    @training_sets << [[:c1, [1,1]], [:c1, [2,2]], [:c2, [10,10]], [:c2, [13,12]]]
    @training_sets << [[:c1, [1,1]], [:c3, [2,2]], [:c2, [10,10]], [:c2, [13,12]]]
    @training_sets << [[:c1, [1,1]], [:c3, [1,2]], [:c1, [2,2]], [:c2, [10,10]], [:c2, [13,12]]]

    @k             = 2

    @training_sets.map! { |i| DataMining::KNearestNeighbor.new(i, @k) }
  end

  def test_classification
    assert_equal :c1, @training_sets[0].classify([:unknown, [2]])
    assert_equal :c2, @training_sets[0].classify([:unknown, [11]])

    assert_equal :c1, @training_sets[1].classify([:unknown, [1,2]])
    assert_equal :c2, @training_sets[1].classify([:unknown, [100,200]])

    assert_equal :c1, @training_sets[2].classify([:unknown, [2,1]])

    assert_equal :c1, @training_sets[3].classify([:unknown, [2,1]])
  end
end
