class MovieFacade
  def service
    MovieService.new
  end

  def movie_results(query)
    service.movie_search(query).map do |data|
      Result.new(data)
    end
  end

  def movie_info(movie_id)
    Movie.new(service.movie_info(movie_id))
  end

  def movie_cast(movie_id)
    service.movie_cast(movie_id).map do |data|
      Cast.new(data)
    end
  end

  def movie_reviews(movie_id)
    service.movie_review(movie_id).map do |data|
      Review.new(data)
    end
  end

  def top_movies
    service.top_rated.map do |data|
      TopRated.new(data)
    end
  end

  def self.get_first_movie(query)
    facade = MovieFacade.new
    movie_id = facade.movie_results('dune')[0].movie_id
    movie = facade.movie_info(movie_id)
  end
end
