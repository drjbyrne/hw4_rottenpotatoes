class AddDirectorsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :Directors, :string
  end
end
