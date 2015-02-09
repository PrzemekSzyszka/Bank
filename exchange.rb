require 'open-uri'
require 'json'

class Exchange
  class InvalidCurrency < StandardError
    def initialize(currency)
      super("Invalid currency #{currency}")
    end
  end

  def convert(money, currency)
    rate = open("http://rate-exchange.appspot.com/currency?from=#{money.currency}&to=#{currency}")
    response_body = rate.read
    response_json = JSON.parse(response_body)

    if response_json.include? "err"
      raise InvalidCurrency, currency
    else
      money.amount * response_json["rate"]
    end
  end
end
