require "test_helper"

describe UsersController do


  # index should redirect to index
    it "can show all users by calling index" do
      get users_path
      must_respond_with :success
    end

    it "succeeds with many users" do
      # Assumption: there are many users in the DB
      User.count.must_be :>, 0

      get users_path
      must_respond_with :success
    end

    it "succeeds with no users" do
      # Start with a clean slate
      User.destroy_all

      get users_path
      must_respond_with :success
    end

    #
    # show should redirect to individual user's page
    it "show user should show one user" do
      get user_path(users(:aurora))
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus user" do
      # User.last gives the user with the highest ID
      bogus_user_id = User.last.id + 1
      get user_path(bogus_user_id)
      must_respond_with 404
    end







end
