require "test_helper"

describe OrdersController do
  describe "#checkout" do
    it "If an order hasn't been created, redirects to index" do
      get checkout_path, params: {session: {order_id: nil}}
      must_respond_with :redirect
      must_redirect_to root_path
    end

    #THIS IS NOT WORKING AND I DON'T KNOW HOW TO FIX IT!
    #don't know how to pass session order_id into my tests.
    # it "gets checkout page if order has been created" do
    #   get checkout_path, params: { session: { order_id: 1 } }
    #   must_respond_with :success
    # end
  end

  describe "#update" do
    it "Gets the Orders Confirmation page" do
      put order_path(orders(:order_one).id)
      must_respond_with :success
    end

    #This isn't working b/c again can't access session order_id
    # it "Updates the status of order to 'Paid'" do
    #   put order_path(orders(:order_one).id)
    #   status = orders(:order_one).status
    #   status.must_equal "Paid"
    # end
  end

  #Need to write a test for if it doesn't work - then what!

  #
end
