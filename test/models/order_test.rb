require "test_helper"

describe Order do
  let(:order) { Order.new }

  it "must have at least one order_item" do
    order.valid?.must_equal false
    order.errors.messages.must_include :order_items
  end

  it "can be created with an order_item" do
    order.order_items = [order_items(:socks)]
    #order items fixture has to be wrapped in an array
    #to_do maybe fix the fixtures?
    order.valid?.must_equal true
  end

  it "can be created with multiple order_items" do
    order.order_items = [order_items(:socks), order_items(:shirts)]
    order.valid?.must_equal true
  end

  it "can access order_items" do
    order.order_items = [order_items(:socks), order_items(:shirts)]
    order.must_respond_to :order_items
  end
end
