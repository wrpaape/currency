require "minitest/autorun"
require_relative '../lib/currency.rb'

class CurrencyTest < Minitest::Test

  def setup
    @amount = 100
    @code = "$"
    @currency = Currency.new(@amount, @code)
  end

  def test_Currency_amount_and_code_exist
    assert(@currency.amount)
    assert(@currency.code)
  end

  def test_parallel_Currency_objects
    currency_same = Currency.new(@amount, @code)
    currency_diff_amount = Currency.new(500, @code)
    currency_diff_code = Currency.new(@amount, "¥")
    assert_equal(true, @currency == currency_same)
    assert_equal(false, @currency == currency_diff_amount)
    assert_equal(false, @currency == currency_diff_code)
  end

end
