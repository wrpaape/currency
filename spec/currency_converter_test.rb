require "minitest/autorun"
require_relative '../lib/currency_converter.rb'
require_relative '../lib/currency.rb'

class Currency_converter_test < Minitest::Test

  def setup
      @cc_default = Currency_converter.new
      @cc_w_input = Currency_converter.new({USD: 1.0, EUR: 0.74, JPY: 120.0})
      @curr_USD = Currency.new(1, "USD")
      @curr_EUR = Currency.new(1, "EUR")
  end

  def test_currency_converter_initialization
    assert_equal(1, @cc_default.curr_table[:USD])
    assert_equal(121.543, @cc_default.curr_table[:JPY])
  end

  def test_currency_converter_converts_to_USD
    assert_equal(0.90867, @cc_default.convert(@curr_USD, "EUR").amount)
    assert_equal(1, @cc_default.convert(@curr_USD, "USD").amount)
    assert_equal(121.543 / 0.90867, @cc_default.convert(@curr_EUR, "JPY").amount)
  end

  def test_currency_converter_initializes_according_to_input
    assert_equal(0.74, @cc_w_input.curr_table[:EUR])
  end

  def test_currency_converter_w_input_converts_properly
    assert_equal(120 / 0.74, @cc_w_input.convert(@curr_EUR, "JPY").amount)
  end

  def test_currency_converter_rejects_small_input_tables
    assert_raises(InputTableTooShort) do Currency_converter.new({USD: 1.0, EUR: 0.74}) end
  end

  def test_currency_converter_converts_to_any_known_currency
    assert_equal(0.90867 / 0.64620, (@cc_default.convert(Currency.new(1, "GBP"), "EUR")).amount)
    assert_equal(1.36916 / 1.27968, (@cc_default.convert(Currency.new(1, "AUD"), "NZD")).amount)
  end

  def test_currency_converter_raises_error_if_code_unknown
    curr_LOL2 = Currency.new(1, "LOL")
    cc_w_LOL2 = Currency_converter.new({USD: 1.0, EUR: 0.74, LOL: 0.001})
    assert_raises(UnkownCurrencyCodeError) do @cc_default.convert(@curr_USD, "LOL") end
    assert_raises(UnkownCurrencyCodeError) do @cc_default.convert(curr_LOL2, "USD") end
    assert_equal(0.74 / 0.001, cc_w_LOL2.convert(curr_LOL2, "EUR").amount)
  end
end
