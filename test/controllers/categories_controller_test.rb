require "test_helper"

#copied this line from the books_app controller test
class CategoriesControllerTest < ActionDispatch::IntegrationTest

    describe CategoriesController do
        let(:category) {categories(:fiction)}
        it "should get index" do
            get categories_path
            must_respond_with :success
        end

        it "should redirect to user page after creating" do

            get auth_github_callback_path, params: { username: users(:felix).username, email: users(:felix).email }
            post categories_path, params: { category: {name: "funky"}}
            must_respond_with :redirect
            must_redirect_to user_path(users(:felix).id)
        end

        it "should show the new form" do
            get new_category_path
            must_respond_with :success
        end

        it "should affect the model when creating a category" do
            proc {
              post auth_github_callback_path, params: { username: users(:felix).username, email: users(:felix).email }
                post categories_path, params: { category: {name: "sci-fi"}} }.must_change 'Category.count', 1
        end


    end
end
