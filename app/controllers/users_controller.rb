class UsersController < ApplicationController
  before_action :require_user, only: [:show]
  def show
    @user = current_user
  end

  def new
  end

  def create
    user = User.create(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to '/dashboard'
    elsif (params[:user][:password] != params[:user][:password_confirmation])
      redirect_to '/register'
      flash[:error] = "Error: Passwords don't match"
    else
      redirect_to '/register'
      flash[:error] = "Error: #{error_message(user.errors)}"
    end
  end

  def discover
  end

  def login_form
  end

  def login_user
    if User.exists?(email: params[:email])
      user = User.find_by email: params[:email]
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to "/dashboard"
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
