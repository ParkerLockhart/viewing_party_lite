class Cast
  attr_reader :movie_id, :name, :character

  def initialize(data)
    @movie_id = data[:id]
    @name = data[:cast][:name]
    @character = data[:cast][:character]
  end
end 
