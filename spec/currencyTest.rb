require "minitest/autorun"
require_relative '../lib/currency.rb'

class CurrencyTest < Minitest::Test

  def setup
    @amount_init = 100
    @amount_diff = 500
    code_init = "$"
    code_diff = "¥"
    @curr_init = Currency.new(@amount_init, code_init)
    @curr_same = Currency.new(@amount_init, code_init)
    @curr_diff_amount = Currency.new(@amount_diff, code_init)
    @curr_diff_code = Currency.new(@amount_init, code_diff)
  end

  def test_Currency_amount_and_code_exist
    assert(@curr_init.amount)
    assert(@curr_init.code)
  end

  def test_parallel_Currency_objects
    assert_equal(true, @curr_init == @curr_same)
    assert_equal(false, @curr_init == @curr_diff_amount)
    assert_equal(false, @curr_init == @curr_diff_code)
  end

  def test_Currency_add
    assert_equal(@amount_init + @amount_diff, (@curr_init + @curr_diff_amount).amount)
    assert_equal(nil, @curr_init + @curr_diff_code)
  end

  def test_Currency_subtract
    assert_equal(@amount_init - @amount_diff, (@curr_init - @curr_diff_amount).amount)
    assert_equal(nil, @curr_init - @curr_diff_code)
  end

end
