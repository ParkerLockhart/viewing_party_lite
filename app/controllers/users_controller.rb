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
    elsif (params[:user][:password] != params[:user][:password_confirmation])
      redirect_to "/register"
      flash[:alert] = "Error: Passwords don't match"
    else
      redirect_to "/register"
      flash[:alert] = "Error: #{error_message(user.errors)}"
    end
  end

  def discover
    @user = User.find(params[:user_id])
  end

  def login_form
  end

  def login_user
    if User.exists?(email: params[:email])
      user = User.find_by email: params[:email]
      if user.authenticate(params[:password])
        redirect_to "/users/#{user.id}"
      else
        redirect_to "/login"
        flash[:alert] = "Error: Unable to authenticate user. Please try again."
      end
    else
      redirect_to "/login"
      flash[:alert] = "Error: Unable to find user with that email. Please try again or register."
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
