class MoviesController < ApplicationController

  def index
    facade = MovieFacade.new
    @user = User.find(params[:user_id])
    if params[:q] == "top rated"
      @movies = facade.top_movies
      @heading = "Top Rated Movies"
    else
      @movies = facade.movie_results(params[:q])
      @heading = "Movie results for: #{params[:q]}"
    end
  end

  def show
    facade = MovieFacade.new
    @user = User.find(params[:user_id])
    @details = facade.movie_info(params[:id])
    @cast = facade.movie_cast(params[:id])
    @reviews = facade.movie_reviews(params[:id])
  end

  def create
    index
  end
end
