class Exchange
  def convert(money, currency)
    case currency
      when "PLN"
        convert_to_pln(money.amount, money.currency)
      when "USD"
        convert_to_usd(money.amount, money.currency)
      when "EUR"
        convert_to_eur(money.amount, money.currency)
      else
        convert_to_gbp(money.amount, money.currency)
    end
  end

  private

  def convert_to_pln(amount, currency)
    case currency
      when "EUR"
        amount * 4.19
      when "USD"
        amount * 3.25
      else
        amount * 5.32
    end
  end

  def convert_to_usd(amount, currency)
    case currency
      when "EUR"
        amount * 1.28
      when "PLN"
        amount / 3.25
      else
        amount * 1.63
    end
  end

  def convert_to_eur(amount, currency)
    case currency
      when "PLN"
        amount / 4.19
      when "USD"
        amount / 1.28
      else
        amount / 0.79
    end
  end

  def convert_to_gbp(amount, currency)
    case currency
      when "EUR"
        amount * 0.79
      when "USD"
        amount / 1.63
      else
        amount / 5.32
    end
  end
end
