require "test_helper"

describe OrderItemsController do
  describe "#Create" do
    it "should redirect to cart when item is created" do
      post new_order_item_path(products(:watch).id), params: {order_item: {quantity: (order_items(:socks).quantity)}}
      must_respond_with :redirect
      must_redirect_to cart_path
    end
  end
end
