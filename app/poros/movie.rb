class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :overview,
              :genres,
              :runtime

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @overview = data[:overview]
    @genres = data[:genres]
    @runtime = data[:runtime]
  end

  def genre_names
    @genres.map do |genre|
      genre[:name]
    end
  end 
end
