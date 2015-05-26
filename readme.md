'lib/currency.rb' contains the Currency class

  -Currency objects possess the attributes 'amount' and 'code'

  -Currency objects can be initialized with the forms:

      curr_obj = Currency.new(amt,"code")

    or

      curr_obj = Currency.new("sym" + "amt")

    where amt is the float or fixnum number value of curr_obj, code is the ISO 4217 currency code of curr_obj, and sym is the symbol representation of the currency code of curr_obj

  -Currency objects of the same 'code' can be added or subtracted from each other with the + and - operators

  -Currency objects can be multiplied by a number with the * operator

  -Currency objects curr_obj1 and curr_obj2 of the same 'amount' and 'code' will return 'true' for the following operation:

    curr_obj1 == curr_obj2


'lib/currency_converter.rb' contains the Currency_converter class

  -Currency_converter objects possess the attribute 'curr_table,' the currency table referred to for conversions

  -Currency_converter objects are initialized with the forms:

      cc_obj = Currency_converter.new

    or

      cc_obj = Currency_converter.new(curr_table)

    where curr_table is a Hash of currency codes to conversion rates.  A Currency_converter object will initialize to a default currency table if it is not passed an argument.

  -Currency_converter objects possess the method .convert that can take a Currency object that has one currency code it knows and a requested currency code and return a new Currency object with the right amount in the new currency code


'lib/currency_trader.rb' contains the Currency_trader class

  -Currency_trader objects possess the attributes 'cc_objs,' 'code_best_trades,' 'best_trades,' and 'roi' where

    cc_objs is an array of Currency_converter objects ordered chronologically that correspond to the state of a currency table at the time of a trade

    code_best_trades is an array of currency codes coressponding to the most appreciating currency from one trade to the next

    best_trades is a string detailing information on the series of best trades over the give timespan

    roi is the profit made if one's starting currency is traded according to the best trades

  -Currency_trader objects are initialized with the form:

      ct_obj = Currency_trader(cc_objs, curr_start)

    where cc_objs is an array of Currency_converter objects ordered chronologically that correspond to the state of a currency table at the time of a trade, and curr_start is a Currency object representing the starting currency

  -Currency_trader objects possess the method .best_trades which returns a string detailing information on the series of best trades over the give timespan

'spec' contains three test files with each file testing a single class

