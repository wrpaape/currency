require_relative 'currency.rb'
require_relative 'currency_converter.rb'

class Currency_trader
  attr_reader :cc_old, :cc_new, :best_bet

  def initialize(curr_table_old, curr_table_new, curr_start)
    @cc_old = Currency_converter.new(curr_table_old)
    @cc_new = Currency_converter.new(curr_table_new)
    @curr_start = curr_start
  end

  def best_bet
    # # conversion rate from current code to table standard
    # code_start = @curr_start.code.to_sym
    # code_std = @cc_old.curr_table.key(1.00000)
    # c1 = @cc_old.curr_table[code_start] ** -1
    # # obtain all potential conversion rates for 1st trade
    # c2_pot =  @cc_old.curr_table
    # puts c2_pot.inspect
    # puts code_start.inspect
    # puts code_std.inspect
    # c2_pot
    # #obtain all potential conversion rates for 2nd trade
    # new_rates_pot =  @cc_new.curr_table.select{ |key| key != code_start && key != code_std }
    #want to trade to currency that appreciates the most (minimizes delta_curr2_rate)
    code_best_trade = most_appreciating_currency
    delta_curr_start = money_made_from_trade(code_best_trade)


  end

  def most_appreciating_currency
    #want to trade to currency that appreciates the most (minimizes delta_curr2_rate)
    delta_curr2_rate = Hash.new
    @cc_old.curr_table.each do |curr2_code, curr2_rate_old|
      delta_curr2_rate[curr2_code] = (@cc_new.curr_table[curr2_code] - curr2_rate_old) / curr2_rate_old
    end
    delta_curr2_rate.key(delta_curr2_rate.values.min)
  end

  def money_made_from_trade(code_trade)
    curr2_old = @cc_old.convert(@curr_start, code_trade)
    curr2_new =
  end


end
