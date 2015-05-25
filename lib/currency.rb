class Currency
  attr_accessor :amount, :code
  CURR_CODE_SYMS = {USD: "$", EUR: "€", GBP: "£", INR: "₹", AUD: "A", CAD: "C", ZAR: "R", NZD: "N", JPY: "¥"}

  def initialize(amount, *code)
    if amount.is_a?(String)
      case amount[0, 1]
      when "A"
        @amount = amount[3, amount.size].to_f
        @code = "AUD"
      when "C"
        @amount = amount[3, amount.size].to_f
        @code = "CAD"
      when "N"
        @amount = amount[3, amount.size].to_f
        @code = "NZD"
      else
        @amount = amount[1, amount.size].to_f
        @code = CURR_CODE_SYMS.key(amount[0, 1]).to_s
      end
    else
      @amount = amount
      @code = code[0]
    end
  end

  def ==(obj)
    class_and_code_equal?(self, obj) && amount.equal?(obj.amount) ? true : false
  end

  def +(obj)
    if class_and_code_equal?(self, obj)
      Currency.new(amount + obj.amount, code)
    elsif self.is_a?(obj.class)
      raise DifferentCurrencyCodeError
    end
  end

  def -(obj)
    if class_and_code_equal?(self, obj)
      Currency.new(amount - obj.amount, code)
    elsif self.is_a?(obj.class)
      raise DifferentCurrencyCodeError
    end
  end

  def *(arg)
    arg = Currency.new(arg, code) unless arg.is_a?(Currency)
    raise DifferentCurrencyCodeError unless code.equal?(arg.code)
    Currency.new(amount * arg.amount, code)
  end

  def coerce(other)
    [self, Currency.new(other, code)] if other.is_a?(Fixnum) || other.is_a?(Float)
  end

  def class_and_code_equal?(obj1, obj2)
    obj1.is_a?(obj2.class) && obj1.code.equal?(obj2.code) ? true : false
  end
end

class DifferentCurrencyCodeError < StandardError
end
