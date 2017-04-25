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


  private
  # this is never used -- commenting out for now
  # def user_params
  #   params.require(:user).permit(:username, :email)
  # end

end
