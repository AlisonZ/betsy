require "test_helper"

describe Product do
  let(:product) { Product.new }

  it "Products require a name" do
    product.valid?.must_equal false

    #hash of all message
    product.errors.messages.must_include :name
  end

  it "Products require a price" do
    product.valid?.must_equal false

    product.errors.messages.must_include :price
  end

  it "If a name and price are given the book is valid" do
    product.name = "My awesome product"
    product.price = 12.99

    product.errors.messages[:name].must_equal []
    product.errors.messages[:price].must_equal []
  end

  it "You can create a product" do
    product.name = "My awesome product"
    product.price = 12.99

    product.save.must_equal true

  end

end
