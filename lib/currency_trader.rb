require_relative 'currency.rb'
require_relative 'currency_converter.rb'

class Currency_trader
  attr_reader :code_best_trade

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
    @code_best_trade = most_appreciating_currency
    delta_curr_start = money_made_from_trade(code_best_trade)
    """
    best trade:     #{code_best_trade.to_s}
    starting funds: #{@curr_start.amount.to_s} #{@curr_start.code}
    final funds:    #{(@curr_start + delta_curr_start).amount} #{@curr_start.code}
    ROI:            #{delta_curr_start.amount} #{@curr_start.code}
    """ +
    "For the span of time provided, trading to #{code_best_trade.to_s} at the start before trading back to " +
    "#{@curr_start.code} at the end would yield the greatest return on investment"

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
    curr_new = @cc_new.convert(curr2_old, @curr_start.code)
    curr_new - @curr_start
  end


end
