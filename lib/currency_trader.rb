class Currency_trader
  attr_reader :cc_objs, :code_best_trades, :best_trades, :roi

  def initialize(cc_objs, curr_start)
    @cc_objs = cc_objs
    @curr_start = curr_start
  end

  def best_trades
    @code_best_trades = []
    curr_current = @curr_start
    @cc_objs.each_with_index do |cc_obj, ind|
      break if ind == @cc_objs.size - 1
      @code_best_trades << most_appreciating_currency(@cc_objs[ind], @cc_objs[ind + 1])
      curr_current = cc_obj.convert(curr_current, @code_best_trades.last)
    end

    curr_final = @cc_objs.last.convert(curr_current, @curr_start.code)
    @roi = curr_final - @curr_start

    trade_path = build_trade_path

    """
    best trade path:  #{trade_path}
    starting funds:   #{@curr_start.amount.round(2)} #{@curr_start.code}
    final funds:      #{curr_final.amount.round(2)} #{curr_final.code}
    ROI:              #{@roi.amount.round(2)} #{@curr_start.code}
    """ +
    "For the span of time provided, trading according to the 'best trade path' would yield the greatest return on investment"
  end

  def most_appreciating_currency(cc_obj_old, cc_obj_new)
    #want to trade to currency that appreciates the most (minimizes delta_curr2_rate)
    delta_curr_rate = Hash.new
    cc_obj_old.curr_table.each do |curr_code, curr_rate_old|
      delta_curr_rate[curr_code] = (cc_obj_new.curr_table[curr_code] - curr_rate_old) / curr_rate_old
    end
    delta_curr_rate.key(delta_curr_rate.values.min)
  end

  def build_trade_path
    trade_path = "#{@curr_start.code} >> "
    @code_best_trades.each { |code| trade_path += code.to_s + " >> " }
    trade_path += "#{@curr_start.code}"
  end
end
