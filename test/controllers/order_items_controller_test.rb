require "test_helper"

describe OrderItemsController do
  describe "#Create" do
    it "should redirect to cart when item is created" do
      post new_order_item_path(products(:watch).id),
        params: {order_item:
          {quantity:   (order_items(:socks).quantity)}}
      must_respond_with :redirect
      must_redirect_to cart_path
    end

    #do we need a test to show where it should go if not added?

    it "should update model if data is good" do
      proc {
        post new_order_item_path(products(:watch).id),
          params: {order_item:
            {quantity:   (order_items(:socks).quantity)}
          }}.must_change 'OrderItem.count', 1
    end

    it "should not update model if data is bad" do
      proc {
        post new_order_item_path(1),
          params: {order_item:
            {quantity: (order_items(:socks).quantity)}
          }}.must_change 'OrderItem.count', 0
    end
  end

  describe "#Cart" do
    it "should get the cart page" do
      get cart_path
      must_respond_with :success
    end
  end
end
