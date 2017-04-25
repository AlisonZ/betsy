class UsersController < ApplicationController
  before_action :check_owner, only: [:show]

  def index
    all_users = User.all
    @users = all_users.find_all { |user| user.products != [] }
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
    if @users == nil
      flash[:warning] = "There are no merchants at this time"
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end


  private
  # this is never used -- commenting out for now
  # def user_params
  #   params.require(:user).permit(:username, :email)
  # end

end
