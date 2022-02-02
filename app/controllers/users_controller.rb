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
    @user = User.find(params[:user_id])
  end

  def search
    user = User.find(params[:user_id])

    query = params[:search]
    query.gsub(/ /, "%20")

    url = 'https://api.themoviedb.org/3/search/movie'
    response = Faraday.get(url + "?api_key=#{ENV['movie_api_key']}&query=#{query}")
    data = JSON.parse(response.body, symbolize_name: true)
    @results = data['results']
  end

  def movies
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

private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
