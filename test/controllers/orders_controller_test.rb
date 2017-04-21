require "test_helper"

describe OrdersController do
  describe "#checkout" do
    it "gets checkout page" do
      get checkout_path, params: {session: {order_id: orders(:order_one).id}}
      must_respond_with :success
    end
  end
end
