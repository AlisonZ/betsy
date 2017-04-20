require "test_helper"

describe Review do
  let(:review) { Review.new }

  it "is valid with a product_id" do
      review = Review.new
      review.product_id = 1
      result = review.valid?
      result.must_equal true
  end

  it "is invalid without a product_id" do
      review = Review.new
      result = review.valid?
      result.must_equal false
      review.errors.messages.must_include :product_id
  end

  it "is valid with a rating" do

  end

end
