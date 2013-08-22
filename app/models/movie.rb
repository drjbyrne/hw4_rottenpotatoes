class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

#  def self.get_similar(id)
#     return Movie.where('director = ?', Movie.find(id).director).group(:title).order(:title)
#   end

  def self.get_similar(id)
        movie = self.find(id)
        director = movie.respond_to?('director') ? movie.director : ''
        if director and !director.empty?
                self.find_all_by_director(director)
              else
                raise 'Error: No Director Information'
#                redirect_to (movies_path)
        end
      end

end

# class Movie::NoDirectorInformation < StandardError; end
