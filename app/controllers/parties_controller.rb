class PartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @viewers = User.not_host(params[:user_id])
    @movie = MovieFacade.movie_info(params[:movie_id])
  end

  def create
    user = User.find(params[:user_id])
    movie = MovieFacade.movie_info(params[:movie_id])

    if params[:duration] < movie.runtime.to_s
      redirect_to "/users/#{user.id}/movies/#{movie.id}/viewing-party/new"
      flash[:alert] = "Error: please enter a duration that is longer than the movie run time."

    else
      party = Party.create(movie_id: params[:movie_id],
                  duration: params[:duration],
                  start_time: params[:start_time])

      PartyUser.create(party_id: party.id,
                      user_id: params[:user_id],
                      host: true)


      if params[:users]
        params[:users].keys.each do |user_id|
          PartyUser.create(party_id: party.id,
                          user_id: user_id,
                          host: false)
        end
      end

      redirect_to "/users/#{params[:user_id]}"
    end
  end
end
