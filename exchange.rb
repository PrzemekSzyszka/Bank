require 'open-uri'
require 'json'

class Exchange
  class InvalidCurrency < StandardError
  end

  def convert(money, currency)
    rate = open("http://rate-exchange.appspot.com/currency?from=#{money.currency}&to=#{currency}")
    response_body = rate.read
    response_json = JSON.parse(response_body)

    if response_json.include? "err"
      raise InvalidCurrency, "Invalid currency #{currency}"
    else
      money.amount * response_json["rate"]
    end
  end
end
