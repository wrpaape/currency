require "minitest/autorun"
require_relative '../lib/currency_converter.rb'

class Currency_converter_test < Minitest::Test

  def setup
      @cc = Currency_converter.new
  end

  def test_currency_converter_initialization
    assert_equal(1, @cc.curr_table[:USD])
    assert_equal(121.543, @cc.curr_table[:JPY])
  end

end
