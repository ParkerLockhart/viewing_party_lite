class PartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @viewers = User.not_host(params[:user_id])
    @movie = MovieFacade.movie_info(params[:movie_id])
  end

  def create
    user = User.find(params[:user_id])
    movie = MovieFacade.movie_info(params[:movie_id])

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

  # def combine_time
  #   d = params[:date].split("/").map {|str| str.to_i}
  #   t = params[:start].split(":").map {|str| str.to_i}
  #   DateTime.new(d[2], d[0], d[1], t[0], t[1], 0)
  # end

end
