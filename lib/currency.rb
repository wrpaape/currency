class Currency
  attr_accessor :amount, :code

  def initialize(amount, code)
    @amount = amount
    @code = code
  end

  def ==(obj)
    self.is_a?(obj.class) && amount.equal?(obj.amount) && code.equal?(obj.code) ? true : false
  end

  def +(obj)
    if self.is_a?(obj.class) && code.equal?(obj.code)
      self.amount += obj.amount
      self
    end
  end

end
