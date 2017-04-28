class SessionsController < ApplicationController

    def create
        #this is me messing around with the google oauth
        def create
            auth_hash = request.env['omniauth.auth']
            raise
        end

        #below here is the working code
        # auth_hash = request.env['omniauth.auth']
        # # if auth_hash['uid']
        # user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
        # if user.nil?
        #     user = User.create_from_github(auth_hash)
        #     if user.nil?
        #         flash[:error] = "Could not log in"
        #         redirect_to :root
        #     end
        # end
        # session[:user_id] = user.id
        # # else
        # #   flash[:error] = 'Could not log in'
        # # end
        # redirect_to :root
    end

    def index
        @user = User.find(session[:user_id])
    end

    def logout
        session[:user_id] = nil
        flash[:success] = "You are successfully logged out"
        redirect_to root_path
    end

end
