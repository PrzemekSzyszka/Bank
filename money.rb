require './exchange.rb'
require 'open-uri'
require 'json'

class Money
  attr_reader :amount, :currency

  class InvalidCurrency < StandardError
  end

  def initialize (amount, currency)
    @amount   = amount
    @currency = currency
  end

  def to_s
    "#{format("%.2f", @amount)} #{@currency}"
  end

  def inspect
    "#<Money #{to_s}>"
  end

  def exchange_to(currency)
    rate = open("http://rate-exchange.appspot.com/currency?from=#{@currency}&to=#{currency}")
    response_body = rate.read
    response_json = JSON.parse(response_body)
    if response_json.include? "err"
      raise InvalidCurrency, "Invalid currency #{currency}"
    else
      @amount * response_json["rate"]
    end
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

    def exchange
      Exchange.new
    end
  end
end
