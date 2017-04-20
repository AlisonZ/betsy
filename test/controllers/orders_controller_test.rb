require "test_helper"

describe OrdersController do
  describe "#Index" do
    it "creates a new Order when something is added to cart" do
      proc { post orders_path, params: { order:
            { status: "New",
              order_items: [order_items(:socks), order_items(:shirts)]
            }}}.must_change 'Order.count', 1
    end
  end
end
