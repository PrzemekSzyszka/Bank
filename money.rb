require './exchange.rb'

class Money
  include Comparable

  attr_reader :amount, :currency

  def initialize (amount, currency)
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

  class << self
    ["usd", "eur", "gbp"].each do |curr|
      define_method "from_#{curr}" do |amount|
        Money.new(amount, curr.upcase)
      end
    end

    def exchange
      Exchange.new
    end
  end
end
