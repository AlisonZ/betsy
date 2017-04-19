require "test_helper"

describe OrderItem do
  let(:order_item) { OrderItem.new }

  it "new order_item requires a quanitity" do
    order_item.valid?.must_equal false
    order_item.errors.messages.must_include :quantity
  end

  it "quantity must be greater than 0" do
    order_item.product_id = products(:fancy_socks).id
    order_item.order_id = orders(:order_one).id
    order_item.quantity = 0
    order_item.valid?.must_equal false
    order_item.errors.messages.must_include :quantity
  end

  it "quantity must be an integer" do
    order_item.product_id = products(:fancy_socks).id
    order_item.order_id = orders(:order_one).id
    order_item.quantity = "two"
    order_item.valid?.must_equal false
    order_item.errors.messages.must_include :quantity
  end

  it "new order_item requires a Product" do
    order_item.quantity = 2
    order_item.valid?.must_equal false
    order_item.errors.messages.must_include :product
  end

  it "new order_item requires an Order" do
    order_item.quantity = 2
    order_item.product_id = products(:fancy_socks).id
    order_item.valid?.must_equal false
    order_item.errors.messages.must_include :order
  end

  it "can create a new order item" do
    order_item.quantity = 2
    order_item.product_id = products(:fancy_socks).id
    order_item.order_id = orders(:order_one).id
    order_item.save.must_equal true
  end

end
