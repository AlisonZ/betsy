require "test_helper"

describe ProductsController do

  describe "#Index" do
    it "should get index" do
        get products_path
        must_respond_with :success
      end
  end

  describe "#Show" do
    it "should show one product" do
        get product_path(products(:umbrella).id)
        must_respond_with :success
      end
  end
end
