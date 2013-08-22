# spec/models/movie_spec.rb
require 'spec_helper'

describe Movie do

  describe 'find movies with same director' do

        it 'searches for similar movies' do
            fake_movie = double('Movie', :director => 'George Lucas')
            Movie.should_receive(:find).with('1').and_return(fake_movie)
            fake_results = [double('Movie'), double('Movie')]
            Movie.should_receive(:find_all_by_director).with('George Lucas').and_return(fake_results)
            Movie.get_similar('1')
          end


        it 'raises an error if there is no director' do
            fake_movie = double('Movie', :director => '')
            Movie.should_receive(:find).with('1').and_return(fake_movie)
            expect { Movie.get_similar('1') }.to raise_exception
          end

  end

end
