require "test_helper"

describe UsersController do


  # index should redirect to index
    it "can show all users by calling index" do
      get users_path
      must_respond_with :success
    end

    # create should change the db count
    it "must update DB upon create" do
      proc { post users_path, params: { user:
            { username: "felicity"
            }
          }
        }.must_change 'User.count', 1
    end


    # create should redirect to root

    it "creating a new user should redirect to root" do
      post users_path, user: {username: "georgianna"}
      must_redirect_to :root
    end
    #
    # show should redirect to individual user's page
    it "show user should show one user" do
      get user_path(users(:aurora))
      must_respond_with :success
    end





end
