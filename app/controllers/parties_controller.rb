class PartiesController < ApplicationController
  before_action :require_user

  def new
    @user = current_user
    @viewers = User.not_host(current_user.id)
    @movie = MovieFacade.movie_info(params[:movie_id])
  end

  def create
    user = current_user
    movie = MovieFacade.movie_info(params[:movie_id])

    if params[:duration].to_i < movie.runtime.to_i
      redirect_to "/movies/#{movie.id}/viewing-party/new"
      flash[:alert] = "Error: please enter a duration that is longer than the movie run time."

    else
      party = Party.create(movie_id: params[:movie_id],
                  duration: params[:duration],
                  start_time: params[:start_time])

      PartyUser.create(party_id: party.id,
                      user_id: user.id,
                      host: true)

      if params[:users]
        params[:users].keys.each do |user_id|
          PartyUser.create(party_id: party.id,
                          user_id: user_id,
                          host: false)
        end
      end

      redirect_to "/dashboard"
    end
  end
end
