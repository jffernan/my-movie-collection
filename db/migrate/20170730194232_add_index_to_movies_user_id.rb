class AddIndexToMoviesUserId < ActiveRecord::Migration[5.1]
  def change
    add_index :movies, :user_id
  end
end
