class Currency
  attr_accessor :amount, :code

  def initialize(amount, code)
    @amount = amount
    @code = code
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
