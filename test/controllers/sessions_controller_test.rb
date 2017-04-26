require "test_helper"




describe SessionsController do

  before do

    # OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    #   'provider' => 'github',
    #   'uid' => '12345',
    #   'info' => {
    #     'nickname' => "fake_name",
    #     'email' => "fake_email"}
    #   })
    #
    #   request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

  end

    it "gets login form" do
      get login_path
      must_respond_with :success
    end


    # Precondition: no user with this username exists
    it "login succeeds for a new user" do

      User.find_by(provider: "github", uid: "1234566").must_be_nil

      get auth_github_callback_path, params: { provider: "github", uid: "1234566" }
      must_redirect_to root_path
    end

    it "login succeeds for a returning user" do
      get auth_github_callback_path, params: { provider: "github", uid: "12345" }
      must_redirect_to root_path
    end

    it "logout succeeds if the user is logged in" do
      # Gotta be logged in first
      get auth_github_callback_path, params: { provider: "github", uid: "12345" }
      must_redirect_to root_path

      delete logout_path
      must_redirect_to root_path
    end

    it "unsuccessful login redirects to login form" do
      get auth_github_callback_path, params: { provider: "github" }
      must_redirect_to root_path
    end
  end
