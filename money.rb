require './exchange.rb'

class Money
  include Comparable

  attr_reader :amount, :currency
  KNOWN_CURRENCIES = ["usd", "eur", "gbp"]

  def initialize (amount, currency = Money.default_currency)
    raise ArgumentError, "wrong number of arguments (2 for 1)" unless currency

    @amount   = amount
    @currency = currency
  end

  def to_s
    "#{format("%.2f", @amount)} #{@currency}"
  end

  def to_int
    exchange_to("PLN").to_i
  end

  def inspect
    "#<Money #{to_s}>"
  end

  def exchange_to(currency)
    Money.exchange.convert(self, currency)
  end

  def <=> (other_money)
    @amount <=> other_money.exchange_to(@currency)
  end

  KNOWN_CURRENCIES.each do |curr|
    define_method "to_#{curr}" do
      exchange_to(curr.upcase)
    end
  end

  def method_missing(m, *args, &block)
    raise NoMethodError, "There's no method called #{m}"
  end

  class << self
    attr_reader :default_currency

    KNOWN_CURRENCIES.each do |curr|
      define_method "from_#{curr}" do |amount|
        Money.new(amount, curr.upcase)
      end
    end

    def using_default_currency(currency)
      begin
        old_currency = default_currency
        @default_currency = currency
        yield
      ensure
        @default_currency = old_currency
      end
    end

    def exchange
      Exchange.new
    end
  end
end
