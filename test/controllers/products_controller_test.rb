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

  describe "#New" do
    it "should get a form for a new product" do
      get new_product_path
      must_respond_with :success
    end
  end

  describe "#Create" do
    it "should redirect to index after creating a new product" do
      post products_path params: { product: {
        name: "My new Product",
        user_id: users(:felix).id,
        description: "This is great!",
        stock: 123,
        price: 12400.00,
        photo_url: "www.url.com",
        selling_status: true,
        category_ids: [categories(:fiction).id, categories(:nonfiction).id]
      } }
      must_respond_with :redirect
      must_redirect_to products_path
    end

    it "should update model after creating a new product" do
      proc { post products_path params: { product: {
        name: "My new Product",
        user_id: users(:felix).id,
        description: "This is great!",
        stock: 123,
        price: 12400.00,
        photo_url: "www.url.com",
        selling_status: true,
        category_ids: [categories(:fiction).id, categories(:nonfiction).id]
      } } }.must_change 'Product.count', 1
    end

    it "should not update model with bad data" do
      proc { post products_path params: { product: {
        name: "",
        user_id: 0,
        description: "This is great!",
        stock: 123,
        price: 00,
        photo_url: "www.url.com",
        selling_status: true,
        category_ids: []
      } } }.must_change 'Product.count', 0
    end
  end

  describe "#Edit" do
    it "should get a form to edit a product" do
      get edit_product_path(products(:umbrella))
      must_respond_with :success
    end
  end

  describe "#Update" do
    it "should redirect to show page after creating a new product" do
      put product_path(products(:umbrella).id), params: { product: {
        name: "Umbrella",
        user_id: users(:aurora).id,
        description: "This is great!",
        stock: 123,
        price: 12400.00,
        photo_url: "www.url.com",
        selling_status: true,
        category_ids: [categories(:fiction).id, categories(:nonfiction).id]
      } }
      must_respond_with :redirect
      must_redirect_to product_path(products(:umbrella).id)
    end

    it "should update info of model if data is valid" do
      old_name = products(:umbrella).name
      put product_path(products(:umbrella).id), params: { product: {
        name: "NEW Umbrella",
        user_id: users(:aurora).id,
        description: "This is great!",
        stock: 123,
        price: 12400.00,
        photo_url: "www.url.com",
        selling_status: true,
        category_ids: [categories(:fiction).id, categories(:nonfiction).id]
      } }
      umbrella = Product.find_by_id(products(:umbrella).id)
      new_name = umbrella.name

      new_name.wont_equal old_name
    end

    it "should not update model if data is bad" do
      old_name = products(:umbrella).name
      put product_path(products(:umbrella).id), params: { product: {
        name: "",
        user_id: 1,
        description: "This is great!",
        stock: 123,
        price: 12400.00,
        photo_url: "www.url.com",
        selling_status: true,
        category_ids: [categories(:fiction).id, categories(:nonfiction).id]
      } }

      umbrella = Product.find_by_id(products(:umbrella).id)
      new_name = umbrella.name

      new_name.must_equal old_name
    end
  end
end
