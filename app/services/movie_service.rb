require 'json'

class MovieService

  def movie_search(query)
    get_url("/?api_key=#{ENV['movie_api_key']}&query=#{query}&language=en-US")
  end

  def movie_cast(movie_id)
    get_url("/movie/#{movie_id}/credits?api_key=#{ENV['movie_api_key']}&language=en-US")
  end

  def movie_review(movie_id)
    get_url("/movie/#{movie_id}/reviews?api_key=#{ENV['movie_api_key']}&language=en-US")
  end

  def movie_info(movie_id)
    get_url("/movie/#{movie_id}?api_key=#{ENV['movie_api_key']}&language=en-US")
  end

  def top_rated
    get_url("/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US")[:results]
  end

  def get_url(url)
    response = Faraday.get("https://api.themoviedb.org/3#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
