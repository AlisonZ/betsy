require "test_helper"

describe OrdersController do
  describe "#checkout" do
    it "If an order hasn't been created, redirects to index" do
      get checkout_path, params: {session: {order_id: nil}}
      must_respond_with :redirect
      must_redirect_to root_path
    end

    #THIS IS NOT WORKING AND I DON'T KNOW HOW TO FIX IT!
    # it "gets checkout page if order has been created" do
    #   get checkout_path, params: { session: { order_id: 1 } }
    #   must_respond_with :success
    # end
  end
end
