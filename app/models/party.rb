class Party < ApplicationRecord
  has_many :party_users
  has_many :users, through: :party_users

  def movie
    facade = MovieFacade.new
    facade.movie_info(self.movie_id)
  end

  def movie_title
    movie.title
  end

  def movie_poster
    movie.poster_path
  end

  def movie_date
    start_time.strftime("%b %-d, %Y")
  end

  def movie_time
    start_time.strftime("%l:%M %p").lstrip()
  end
end
