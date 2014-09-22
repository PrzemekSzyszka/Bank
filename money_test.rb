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
    assert @money.amount != Money.exchange.convert(@money, "PLN")
  end

  def test_exchange_to_raises_invalid_currency_error
    assert_raises Exchange::InvalidCurrency do |variable|
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

  def test_when_case_returns_ok
    case @money
    when Money(20, "PLN")..Money(30, "PLN") then result = "fail"
    when Money(30, "PLN")..Money(40, "PLN") then result = "OK"
    when Money(40, "PLN")..Money(50, "PLN") then result = "fail"
    end

    assert_equal "OK", result
  end

  def test_to_eur_changes_amount
    assert 10 != Money(20, "PLN").to_eur
  end

  def test_to_chf_should_return_no_method_error
    assert_raises NoMethodError do
      assert 10 != Money(20, "PLN").to_chf
    end
  end
end
