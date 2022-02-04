require 'rails_helper'

RSpec.describe MovieService do
  describe 'class methods' do
    describe 'movie_search' do
      before(:each) do
        VCR.insert_cassette('user_dune_search')
      end
      after(:each) do
        VCR.eject_cassette('user_dune_search')
      end

      let!(:search) {MovieService.movie_search('dune')}
      let!(:result) {search[:results].first}

      it 'returns response hash' do
        expect(search).to be_a Hash
      end

      it 'response hash contains results array' do
        expect(search[:results]).to be_a Array
      end

      it 'results array elements contain movie hash' do
        expect(result).to be_a Hash
      end

      it 'movie hash contains movie data' do
        expect(result).to have_key :id
        expect(result[:id]).to be_a Integer

        expect(result).to have_key :title
        expect(result[:title]).to be_a String

        expect(result).to have_key :vote_average
        expect(result[:vote_average]).to be_a Float
      end
    end
  end

  describe 'movie_cast' do
    before(:each) do
      VCR.insert_cassette('dune_cast')
    end
    after(:each) do
      VCR.eject_cassette('dune_cast')
    end
    let!(:credits) {MovieService.movie_cast(438631)}
    let!(:member) {credits[:cast].first}

    it 'returns a response hash' do
      expect(credits).to be_a Hash
    end

    it 'response contains cast member array' do
      expect(credits[:cast]).to be_a Array
    end

    it 'cast array elements contain member hash' do
      expect(member).to be_a Hash
    end

    it 'cast member hash contains actor data' do
      expect(member).to have_key(:name)
      expect(member[:name]).to be_a String

      expect(member).to have_key(:character)
      expect(member[:character]).to be_a String
    end
  end

  describe 'movie_review' do
    before(:each) do
      VCR.insert_cassette('dune_reviews')
    end
    after(:each) do
      VCR.eject_cassette('dune_reviews')
    end

    let!(:reviews) {MovieService.movie_review(438631)}
    let!(:review) {reviews[:results].first}

    it 'returns response hash' do
      expect(reviews).to be_a Hash
    end

    it 'response contains reviews array' do
      expect(reviews[:results]).to be_a Array
    end

    it 'reviews array elements contain review hash' do
      expect(review).to be_a Hash
    end

    it 'review hash contains review data' do
      expect(review).to have_key :author
      expect(review[:author]).to be_a String

      expect(review).to have_key :content
      expect(review[:content]).to be_a String
    end
  end

  describe 'movie_info' do
    before(:each) do
      VCR.insert_cassette('dune_details')
    end
    after(:each) do
      VCR.eject_cassette('dune_details')
    end

    let!(:info) {MovieService.movie_info(438631)}

    it 'returns response hash' do
      expect(info).to be_a Hash
    end

    it 'info hash contains movie data' do
      expect(info).to have_key :id
      expect(info[:id]).to be_a Integer

      expect(info).to have_key :title
      expect(info[:title]).to be_a String

      expect(info).to have_key :vote_average
      expect(info[:vote_average]).to be_a Float

      expect(info).to have_key :overview
      expect(info[:overview]).to be_a String

      expect(info).to have_key :genres
      expect(info[:genres]).to be_a Array
      expect(info[:genres].first).to be_a Hash
      expect(info[:genres].first[:name]).to be_a String

      expect(info).to have_key :runtime
      expect(info[:runtime]).to be_a Integer

      expect(info).to have_key :poster_path
      expect(info[:poster_path]).to be_a String
    end
  end

  describe 'top_rated' do
    before(:each) do
      VCR.insert_cassette('top_rated_search')
    end
    after(:each) do
      VCR.eject_cassette('top_rated_search')
    end

    let!(:top_rated) {MovieService.top_rated}
    let!(:top_movie) {top_rated[:results].first}

    it 'returns response hash' do
      expect(top_rated).to be_a Hash
    end

    it 'response hash contains top movie array' do
      expect(top_rated[:results]).to be_a Array
    end

    it 'results array elements contain movie hash' do
      expect(top_movie).to be_a Hash
    end

    it 'movie hash contains movie data' do
      expect(top_movie).to have_key :id
      expect(top_movie[:id]).to be_a Integer

      expect(top_movie).to have_key :title
      expect(top_movie[:title]).to be_a String

      expect(top_movie).to have_key :vote_average
      expect(top_movie[:vote_average]).to be_a Float
    end
  end
end
