require 'minitest/autorun'
require './money.rb'

class MoneyTest < Minitest::Test
  def setup
    @money = Money.new(10, "USD")
  end

  def test_to_s_method
    assert_equal @money.to_s, "10.00 USD"
  end

  def test_inspect_method
    assert_equal @money.inspect, "#<Money 10.00 USD>"
  end
end
