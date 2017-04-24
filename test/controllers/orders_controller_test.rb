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

    #FAILLING RIGHT NOW AND I DON'T KNOW WHY!
    it "Updates the status of order to 'Paid'" do
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
      status = orders(:order_one).status
      status.must_equal "Paid"
    end
  end

  #Need to write a test for if it doesn't work - then what!

  #
end
