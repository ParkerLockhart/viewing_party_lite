class Result
  attr_reader :movie_id, :title, :vote_average

  def initialize(data)
    @movie_id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
  end
end
