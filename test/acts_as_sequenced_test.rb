require 'test_helper'

class ActsAsSequencedTest < ActiveSupport::TestCase
  test "returns 1 if first row" do
    account = Account.create
    order = account.orders.create(product: "Big yellow bunny!")
    assert_equal 1, order.number
  end

  test "returns numbers scoped by value provided" do
    first_account = Account.create
    first_order = first_account.orders.create(product: "Big yellow bunny!")
    second_account = Account.create
    second_order = second_account.orders.create(product: "Big brown bear!")

    assert_equal 1, first_order.number
    assert_equal 1, second_order.number
  end
end
