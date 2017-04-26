class UsersController < ApplicationController
  before_action :check_owner, only: [:show]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end

  def show
    @user = User.find_by_id(params[:id])

    @purchases = Order.where(email: @user.email)
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      flash[:success] = "Successfully updated user profile"
      redirect_to user_path(current_user.id)
    else
      flash.now[:error] = "Unable to update user profile at this time"
      render :edit
    end
  end


  private
  # this is never used -- commenting out for now
  def user_params
    params.require(:user).permit(:username, :email, :profile)
  end

end
