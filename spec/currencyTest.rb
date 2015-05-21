require "minitest/autorun"
require_relative '../lib/currency.rb'

class CurrencyTest < Minitest::Test

  def setup
    amount = 100
    code = "$"
    @currency = Currency.new(amount, code)
  end

  def test_Currency_amount_and_code_exist
    assert(@currency.amount)
    assert(@currency.code)
  end

end
