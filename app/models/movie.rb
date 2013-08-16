class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.get_similar(id)
     return Movie.where('director = ?', Movie.find(id).director).group(:title).order(:title)
   end

end
