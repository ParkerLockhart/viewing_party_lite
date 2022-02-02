class Review
  attr_reader :movie_id, :author, :content

  def initialize(data)
    @movie_id = data[:id]
    @author = data[:results][:author]
    @content = data[:results][:content]
  end
end 
