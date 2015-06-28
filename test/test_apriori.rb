require 'test_helper'

class DataMining::AprioriTest < MiniTest::Unit::TestCase
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

    # { 1=>[[:prod_x],[:prod_y]], 2=>[[:prod_x, :prod_y]] }
    @result = DataMining::Apriori.new(@transactions, @min_support)
    @result.mine!
  end

  def test_correct_amount_of_itemsets
    assert_equal 5, @result[1].size
    assert_equal 6, @result[2].size
    assert_equal 2, @result[3].size
  end

end
