require 'spec_helper'

describe MoviesController, :type => :controller do

  describe 'find a movie' do
      it 'shows the movie information' do
          movie = double('Movie')
          Movie.should_receive(:find).with('1').and_return(movie)
           get :show, {:id => '1'}
          response.should render_template('show')
        end
    end


  describe 'list all movies' do

        it 'finds and lists all movies' do
            fake_results = [double('Movie'), double('Movie')]
            Movie.should_receive(:find_all_by_rating).and_return(fake_results)
            get :index
            response.should render_template('index')
          end

        it 'finds & lists all movies, sorted by title' do
            get :index, {:sort => 'title', :ratings => 'PG'}
            response.should redirect_to(:sort => 'title', :ratings => 'PG')
          end

        it 'finds & lists all movies, sorted by release_date' do
            get :index, {:sort => 'release_date', :ratings => 'PG'}
            response.should redirect_to(:sort => 'release_date', :ratings => 'PG')
          end

        it 'finds & lists all movies with rating PG' do
            get :index, {:ratings => 'PG'}
            response.should redirect_to(:ratings => 'PG')
          end

      end


    describe 'show form to add a movie' do
        it 'shows the form for user to add new movie info' do
            get :new
            response.should render_template('new')
          end
      end


    describe 'create a movie' do
        it 'creates a movie successfully' do
            movie = double('Movie', :title => 'The Help')
            Movie.should_receive(:create!).and_return(movie)
            post :create, :movie => movie
            response.should redirect_to(movies_path)
          end
      end


    describe 'edit a movie' do
        it 'shows the form to edit movie info' do
            movie = double('Movie', :title => 'The Help')
            Movie.should_receive(:find).with('1').and_return(movie)
            get :edit, :id => '1'
            response.should render_template('edit')
          end
      end


    describe 'update a movie' do
        it 'updates movie information' do
            movie = double('Movie', :id => '1', :title => 'The Help')
            Movie.should_receive(:find).with('1').and_return(movie)
            movie.should_receive(:update_attributes!)
            put :update, :id => '1', :movie => movie
            response.should redirect_to movie_path(movie)
          end
      end


    describe 'delete a movie' do
        it 'deletes a movie' do
            movie = double('Movie', :id => '1', :title => 'The Help')
            Movie.should_receive(:find).with('1').and_return(movie)
            movie.should_receive(:destroy)
            delete :destroy, :id => '1'
            response.should redirect_to(movies_path)
          end
      end


    describe 'find movies with the same director' do

        it 'shows other movies with the same director' do
            movie = double('Movie')
            movie.stub(:title).and_return('The Help')
            movie.stub(:director).and_return('Director Name')
            Movie.should_receive(:find).with('1').and_return(movie)
            fake_results = [double('Movie'), double('Movie')]
            Movie.should_receive(:get_similar).with('1').and_return(fake_results)
            get :similar, {:id => "1"}
            response.should render_template('similar')
          end


        it 'redirects to home page and shows a warning for no director info' do
            movie = double('Movie')
            movie.stub(:title).and_return('The Help')
            Movie.should_receive(:find).with('1').and_return(movie)
            Movie.stub(:get_similar).and_raise
            get :similar, {:id => "1"}
            response.should redirect_to(movies_path)
          end

      end
end
