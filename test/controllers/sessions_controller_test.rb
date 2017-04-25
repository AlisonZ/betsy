require "test_helper"

describe SessionsController do
  it "gets login form" do
    get login_path
    must_respond_with :success
  end


  it "login succeeds for a new user" do
      username = "test_user"
      # Precondition: no user with this username exists
      User.find_by(username: username, email: "email").must_be_nil

      post login_path, params: { username: username, email: "email" }
      must_redirect_to root_path
    end

    it "login succeeds for a returning user" do
      username = User.first.username
      post login_path, params: { username: username, email: User.first.email }
      must_redirect_to root_path
    end

    it "logout succeeds if the user is logged in" do
      # Gotta be logged in first
      post login_path, params: { username: "test user", email: "email" }
      must_redirect_to root_path

      delete login_path
      must_redirect_to root_path
    end

    it "unsuccessful login redirects to login form" do
      post login_path, params: { username: ""}
      must_respond_with :success
      # it's not throwing an error, just redirecting
    end
end
