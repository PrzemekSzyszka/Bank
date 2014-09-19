require 'minitest/autorun'
require './money.rb'

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
end
