class SessionsController < ApplicationController

  def new
  end

  def create
    if User.exists?(email: params[:email])
      user = User.find_by email: params[:email]
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.name}!"
        redirect_to '/dashboard'
      else
        flash.now[:error] = "Error: Incorrect password. Please try again."
        render :new
      end
    else
      flash.now[:error] = "Error: Unable to find user with that email. Please try again, or register if you are a new user."
      render :new
    end
  end

  def destroy
    session.destroy
    flash[:notice] = "Logout successful."
    redirect_to root_path
  end
end
