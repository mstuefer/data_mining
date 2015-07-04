require 'test_helper'

class DataMining::AprioriTest < MiniTest::Test
  def setup
    @transactions = []
    @transactions << [:transaction1, [:prod_a, :prod_b, :prod_e]]
    @transactions << [:transaction2, [:prod_b, :prod_d]]
    @transactions << [:transaction3, [:prod_b, :prod_c]]
    @transactions << [:transaction4, [:prod_a, :prod_b, :prod_d]]
    @transactions << [:transaction5, [:prod_a, :prod_c]]
    @transactions << [:transaction6, [:prod_b, :prod_c]]
    @transactions << [:transaction7, [:prod_a, :prod_c]]
    @transactions << [:transaction8, [:prod_a, :prod_b, :prod_c, :prod_e]]
    @transactions << [:transaction9, [:prod_a, :prod_b, :prod_c]]
    @min_support  = 2

    @result = DataMining::Apriori.new(@transactions, @min_support)
    @result.mine!
  end

  def test_correct_amount_of_itemsets
    assert_equal 5, @result.results[0].size
    assert_equal 6, @result.results[1].size
    assert_equal 2, @result.results[2].size
    assert_equal 0, @result.results[3].size

    assert_equal 5, @result.item_sets_size(1).size
    assert_equal 0, @result.item_sets_size(4).size

    assert_nil      @result.results[4]
    assert_nil      @result.item_sets_size(5)
  end

  def test_correct_associations
    assert_equal [[:prod_a, :prod_b, :prod_c], [:prod_a, :prod_b, :prod_e]], @result.results[2]
    assert_equal [[:prod_a, :prod_b, :prod_c], [:prod_a, :prod_b, :prod_e]], @result.item_sets_size(3)
  end

end
