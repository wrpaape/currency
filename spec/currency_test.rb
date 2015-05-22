require "minitest/autorun"
require_relative '../lib/currency.rb'

class Currency_test < Minitest::Test

  def setup
    @amount_init = 100
    @amount_diff = 500
    @fixnum_num = 50
    @float_num = 0.1.to_f
    code_init = "$"
    code_diff = "¥"
    @curr_init = Currency.new(@amount_init, code_init)
    @curr_same = Currency.new(@amount_init, code_init)
    @curr_diff_amount = Currency.new(@amount_diff, code_init)
    @curr_diff_code = Currency.new(@amount_init, code_diff)
  end

  def test_currency_amount_and_code_exist
    assert(@curr_init.amount)
    assert(@curr_init.code)
  end

  def test_parallel_currency_objects
    assert_equal(true, @curr_init == @curr_same)
    assert_equal(false, @curr_init == @curr_diff_amount)
    assert_equal(false, @curr_init == @curr_diff_code)
  end

  def test_currency_add
    assert_equal(@amount_init + @amount_diff, (@curr_init + @curr_diff_amount).amount)
    assert_raises(DifferentCurrencyCodeError) do (@curr_init + @curr_diff_code) end
  end

  def test_currency_subtract
    assert_equal(@amount_init - @amount_diff, (@curr_init - @curr_diff_amount).amount)
    assert_raises(DifferentCurrencyCodeError) do (@curr_init - @curr_diff_code) end
  end

  def test_currency_multiply
    assert_equal(5000, (@fixnum_num * @curr_init).amount)
    assert_equal(5000, (@curr_init * @fixnum_num).amount)
    assert_equal(10, (@float_num * @curr_init).amount)
    assert_equal(10, (@curr_init * @float_num).amount)
    assert_equal(10000, (@curr_init * @curr_same).amount)
    assert_raises(DifferentCurrencyCodeError) do (@curr_init * @curr_diff_code) end
  end

end
