require "test_helper"

describe ProductsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  it "should get index" do
      get products_path
      must_respond_with :success
    end

  it "should show one product" do
      get products_path(products(:umbrella).id)
      must_respond_with :success
    end

end
