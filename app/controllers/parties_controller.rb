class PartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @viewers = User.not_host(params[:user_id])
    @movie = MovieFacade.movie_info(params[:movie_id])
  end

  def create
    require "pry"; binding.pry
    redirect_to
  end

end
