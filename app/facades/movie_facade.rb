class MovieFacade

  def self.movie_results(query)
    MovieService.movie_search(query)[:results].map do |data|
      Result.new(data)
    end
  end

  def self.movie_info(movie_id)
    Movie.new(MovieService.movie_info(movie_id))
  end

  def self.movie_cast(movie_id)
    MovieService.movie_cast(movie_id)[:cast].map do |data|
      Cast.new(data)
    end
  end

  def self.movie_reviews(movie_id)
    MovieService.movie_review(movie_id)[:results].map do |data|
      Review.new(data)
    end
  end

  def self.top_movies
    MovieService.top_rated[:results].map do |data|
      TopRated.new(data)
    end
  end
end
