require "test_helper"

#copied this line from the books_app controller test
class CategoriesControllerTest < ActionDispatch::IntegrationTest

    describe CategoriesController do
        let(:category) {categories(:fiction)}
        it "should get index" do
            get categories_path
            must_respond_with :success
        end

        it "should get show" do
            get category_path(1)
            must_respond_with :success
        end

        it "should show the new form" do
            get new_category_path
            must_respond_with :success
        end

        it "should affect the model when creating a category" do
            proc {
                post categories_path, params: { category: {name: "sci-fi"}} }.must_change 'Category.count', 1
        end

        it "should redirect to category index after creating a new category" do
            post categories_path, params:{ category: {name: "chick lit"}}
            must_respond_with :redirect
            must_redirect_to categories_path
        end
    end
end
