require 'test_helper'

class ConcurrencyTest < ActiveSupport::TestCase
  def setup
    Order.delete_all
  end

  def teardown
    Order.delete_all
  end

  test "creates records concurrently without data races" do
    account = Account.create
    Thread.abort_on_exception = true
    range = (1..50)

    threads = []
    range.each do
      threads << Thread.new do
        account.orders.create!(product: "Plish yoda toy!")
      end
    end

    threads.each(&:join)

    sequential_numbers = Order.pluck(:number)
    assert_equal range.to_a, sequential_numbers
  end

  test "does not affect saving multiple records within a transaction" do
    account = Account.create
    range = (1..10)

    Order.transaction do
      range.each do
        account.orders.create!(product: "Happy Dath V.")
      end
    end

    sequential_numbers = Order.pluck(:number)
    assert_equal range.to_a, sequential_numbers
  end

  test "does not affect saving multiple records within nested transactons" do
    account = Account.create
    range = (1..10)

    Order.transaction do
      Order.transaction do
        Order.transaction do
          range.each do
            account.orders.create!(product: "Happy Dath V.")
          end
        end
      end
    end

    sequential_numbers = Order.pluck(:number)
    assert_equal range.to_a, sequential_numbers
  end
end
