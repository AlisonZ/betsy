class SessionsController < ApplicationController

  @user = User.find_by_username(params[:username])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
      redirect_to :root
    else
      @user = User.create(username: params[:username])
      if @user.id != nil
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
        redirect_to :root
      else
        flash.now[:failure] = "Sorry, unable to log in at this time"
        render :login_form
      end
    end

    
end
