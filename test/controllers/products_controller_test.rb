require "test_helper"

describe ProductsController do

  describe "#Index" do
    it "should get index" do
        get products_path
        must_respond_with :success
    end

    it "works with multiple works" do
      Product.count.must_be :>, 0
      get products_path
      must_respond_with :success
    end

    it "still works if there are no products" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end
  end

  describe "#Show" do
    it "should show one product" do
        get product_path(products(:umbrella).id)
        must_respond_with :success
    end

    it "should show a 404 if product not found" do
        get product_path(1)
        must_respond_with :missing
    end
  end
end
