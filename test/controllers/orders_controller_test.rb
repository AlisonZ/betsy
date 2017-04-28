require "test_helper"

describe OrdersController do
  describe "#checkout" do
    it "If an order hasn't been created, redirects to index" do
      get checkout_path, params: {session: {order_id: nil}}
      must_respond_with :redirect
      must_redirect_to root_path
    end

    #Have to pass session in by hitting the path where it is established
    #in our case adding new order_item
    it "gets checkout page if order has been created" do
      post new_order_item_path(products(:fancy_socks).id),
        params: {order_item:
          {quantity:   (order_items(:socks).quantity)}
        }
      get checkout_path
      must_respond_with :success
    end
  end

  describe "#update" do
    it "Gets the Orders Confirmation page" do
      post new_order_item_path(products(:fancy_socks).id),
        params: {order_item:
          {quantity:   (order_items(:socks).quantity)}
        }
      put order_path(orders(:order_one).id), params: {order:
        {email: "lynn@gmail.com",
         name_on_cc: "Lynn Trickey",
         cc_number: 123,
         cc_ccv: 123,
         billing_zip: 123,
         address: "123 Avenue St.",
         }}
      must_respond_with :success
    end

    it "Updates the status of order to 'paid'" do
      # Initialize the cart by adding an item to it
      post new_order_item_path(products(:fancy_socks).id),
        params: {order_item:
          {quantity:   (order_items(:socks).quantity)}
        }

      # Get the newly created order (should be the last row in the Order table)
      order = Order.last
      old_status = order.status

      put order_path(order.id), params: {order:
        {email: "lynn@gmail.com",
         name_on_cc: "Lynn Trickey",
         cc_number: 123,
         cc_ccv: 123,
         billing_zip: 123,
         address: "123 Avenue St.",
         }}
         order = Order.find(order.id)
         order.status.must_equal "paid"
         new_status = order.status

         new_status.wont_equal old_status
    end

    it "if order does not exist, should redirect to root path" do
      put order_path(1)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
