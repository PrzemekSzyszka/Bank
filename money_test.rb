require 'minitest/autorun'
require './money.rb'
require './object.rb'

class MoneyTest < Minitest::Test
  def setup
    @money = Money.new(10, "USD")
  end

  def test_to_s_method
    assert_equal "10.00 USD", @money.to_s
  end

  def test_inspect_method
    assert_equal "#<Money 10.00 USD>", @money.inspect
  end

  def test_from_usd_method
    assert_equal "#<Money 12.00 USD>", Money.from_usd(12).inspect
  end

  def test_from_eur_method
    assert_equal "#<Money 12.00 EUR>", Money.from_eur(12).inspect
  end

  def test_from_gbp_method
    assert_equal "#<Money 12.00 GBP>", Money.from_gbp(12).inspect
  end

  def test_object_money_method
    assert_equal "#<Money 15.00 PLN>", Money(15, "PLN").inspect
  end

  def test_exchange_from_dolars_to_pln
    assert_equal 32.5, Money.exchange.convert(@money, "PLN")
  end

  def test_exchange_to_raises_invalid_currency_error
    assert_raises Money::InvalidCurrency do |variable|
      @money.exchange_to("XYZ")
    end
  end

  def test_exchange_to_returns_amount_in_usd
    assert_equal 10, @money.exchange_to("USD")
  end

  def test_money1_should_be_grater_than_money2
    assert Money(20, "USD") > Money(10, "PLN")
  end

  def test_money1_should_be_equal_to_money2
    assert Money(10, "PLN") == Money(10, "PLN")
  end

  def test_money1_should_be_lower_to_money2
    assert Money(10, "PLN") < Money(10, "EUR")
  end
end
