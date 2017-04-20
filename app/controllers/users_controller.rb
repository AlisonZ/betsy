class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
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
