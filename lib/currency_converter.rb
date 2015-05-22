class Currency_converter
attr_accessor :curr_table
CURR_CODES = "USD EUR GBP INR AUD CAD ZAR NZD JPY".split(" ")
CONV_RATES = "1.00000 0.90867 0.64620 63.4724 1.27968 1.23039 11.8959 1.36916 121.543".split(" ")

  def initialize
    @curr_table = Hash.new()
    CURR_CODES.each_with_index { |code, ind| @curr_table[code.to_sym] = CONV_RATES[ind].to_f }
  end

end
