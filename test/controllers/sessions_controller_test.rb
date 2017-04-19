require "test_helper"

describe SessionsController do
  it "gets login form" do
    get login_path
    must_respond_with :success
  end
end
