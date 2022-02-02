class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:alert] = "Error: please enter a name and unique email to register."
    end
  end

  def discover
  end 

private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
