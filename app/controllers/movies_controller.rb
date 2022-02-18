class MoviesController < ApplicationController

  def index
    if params[:q] == "top rated"
      @movies = MovieFacade.top_movies
      @heading = "Top Rated Movies"
    else
      @movies = MovieFacade.movie_results(params[:q])
      @heading = "Movie results for: #{params[:q]}"
    end
  end

  def show
    @details = MovieFacade.movie_info(params[:id])
    @cast = MovieFacade.movie_cast(params[:id])
    @reviews = MovieFacade.movie_reviews(params[:id])
  end
end
