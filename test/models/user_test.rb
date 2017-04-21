require "test_helper"

describe User do
  let(:user) { User.new }

  it "can create a new user" do
    user = User.new(username: "louise", email: "louise@test.com")
    user.save.must_equal true
  end

  # requires a username
  it "must have a username" do
    user = User.new(email: "louise@test.com")
    user.save.must_equal false
  end

  # username is unique
  it "username must be unique" do
    user = User.new(email: "test@test.com", username: "auroralemieux")
    user.save.must_equal false
  end

  # requires an email
  it "must have an email" do
    user = User.new(username: "auro")
    user.save.must_equal false
  end

  # email is unique
  it "email must be unique" do
    user = User.new(username: "pinky", email: "aurora@test.com")
    user.save.must_equal false
  end

  # has many products
  it "has many products" do
    user = users(:aurora)
    user_products = user.products
    user_products.each do |product|
      product.must_be_kind_of Product
    end
  end

  describe "#Orders" do
    it "returns a list of past orders" do
      user = users(:aurora)
      orders = user.orders
      orders.each do |order|
        order.must_be_instance_of Order
      end
    end

    it "If user has no past orders, returns empty array" do
      user = users(:felix)
      orders = user.orders
      orders.must_equal []
    end
  end
end
