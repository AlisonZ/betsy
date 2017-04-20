class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    render_404 if !@user
  end


  private

  def user_params
    params.require(:user).permit(:username, :email)
  end

end
