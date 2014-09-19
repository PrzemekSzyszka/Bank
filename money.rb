class Money
  attr_reader :amount, :currency

  def initialize (amount, currency)
    @amount = amount
    @currency = currency
  end

  def to_s
    "#{format("%.2f", @amount)} #{@currency}"
  end

  def inspect
    "#<Money #{to_s}>"
  end

  class << self
    [:from_usd, :from_eur, :from_gbp].each do |method|
      define_method method do |amount|
        case method
          when :from_usd
            Money.new(amount, "USD")
          when :from_eur
            Money.new(amount, "EUR")
          else
            Money.new(amount, "GBP")
        end
      end
    end
  end
end
