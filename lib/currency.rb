class Currency
  attr_accessor :amount, :code

  def initialize(amount, code)
    @amount = amount
    @code = code
  end

  def ==(obj)
    self.is_a?(obj.class) && amount.equal?(obj.amount) && code.equal?(obj.code) ? true : false
  end

end
