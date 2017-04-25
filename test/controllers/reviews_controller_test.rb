require "test_helper"

describe ReviewsController do

  describe "#New" do
    it "should get a form to create a new review" do
        get new_product_review_path(products(:watch).id)
        must_respond_with :success
    end
  end

  describe "#Create" do
    it "should change model when creating new review" do
        proc{
            post product_reviews_path(products(:watch).id), params: { review: {
              title: "I love this Product",
              rating: 4,
              review_text: "Seriously, best watch ever!"
              } }
        }.must_change 'Review.count', 1
    end

    it "Should redirect to product show page if created successfully" do
      post product_reviews_path(products(:watch).id), params: { review: {
        title: "I love this Product",
        rating: 4,
        review_text: "Seriously, best watch ever!"
        } }
      must_respond_with :redirect
      must_redirect_to product_path(products(:watch).id)
    end

    it "should not affect the model if data is bad" do
      proc{
          post product_reviews_path(products(:watch).id), params: { review: {
            title: "I love this Product",
            rating: -1,
            review_text: "Seriously, best watch ever!"
            } }
      }.must_change 'Review.count', 0
    end

    # this test is failing because the conditional is in the view instead of as a controller before action
    it "should not allow review on user's own product" do
      post login_path, params: { username: users(:aurora).username, email: users(:aurora).email }
      post product_reviews_path(products(:fancy_socks).id), params: { review: {
            title: "this is fake",
            rating: 4,
            review_text: "awesome!"
            } }
      must_respond_with :error
    end
  end
end
