require "minitest/autorun"
require_relative '../lib/currency_converter.rb'
require_relative '../lib/currency.rb'

class Currency_converter_test < Minitest::Test

  def setup
      @cc = Currency_converter.new
      @curr_USD = Currency.new(1, "USD")
  end

  def test_currency_converter_initialization
    assert_equal(1, @cc.curr_table[:USD])
    assert_equal(121.543, @cc.curr_table[:JPY])
  end

  def test_currency_converter_converts_to_USD
    assert_equal(0.90867, @cc.convert(@curr_USD, "EUR").amount)
  end

end
