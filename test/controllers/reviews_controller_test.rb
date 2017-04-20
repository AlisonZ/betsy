require "test_helper"

describe ReviewsController do
    let(:category) {categories(:fiction)}

    it "should get new" do
        get new_review_path
        must_respond_with :success
    end

    it "should change model when creating new review" do
        proc{
            post reviews_path, params: { review: {product_id: 4} }
        }.must_change 'Review.count', 1
    end
    
    it "should affect the model when creating a category" do
        proc {
            post categories_path, params: { category: {name: "sci-fi"}}
        }.must_change 'Category.count', 1
    end
end
