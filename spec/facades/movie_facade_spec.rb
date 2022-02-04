require 'rails_helper'

RSpec.describe MovieFacade do
  describe 'movie_results' do
    it 'returns search result movie array' do
      VCR.use_cassette('user_dune_search') do
        results = MovieFacade.movie_results('dune')

        expect(results).to be_a Array

        results.each do |result|
          expect(result).to be_instance_of Result
        end
      end
    end
  end

  describe 'movie_info' do
    it 'returns details for a movie' do
      VCR.use_cassette('dune_details') do
        dune = MovieFacade.movie_info(438631)

        expect(dune).to be_instance_of Movie
      end
    end
  end

  describe 'movie_review' do
    it 'returns array of reviews for movie' do
      VCR.use_cassette('dune_reviews') do
        reviews = MovieFacade.movie_reviews(438631)

        expect(reviews).to be_a Array

        reviews.each do |review|
          expect(review).to be_instance_of Review
        end
      end
    end
  end

  describe 'movie_cast' do
    it 'returns array of cast members for movie' do
      VCR.use_cassette('dune_cast') do
        cast = MovieFacade.movie_cast(438631)

        expect(cast).to be_a Array

        cast.each do |member|
          expect(member).to be_instance_of Cast
        end
      end
    end
  end

  describe 'top_movies' do
    it 'returns array of top rated movies' do
      VCR.use_cassette('top_rated_search') do
        top_movies = MovieFacade.top_movies

        expect(top_movies).to be_a Array

        top_movies.each do |movie|
          expect(movie).to be_instance_of TopRated
        end
      end
    end
  end
end
