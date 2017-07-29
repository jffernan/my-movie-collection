class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :comment
      t.date :date_purchased
      t.integer :user_id #movie has 1 user who bought it
    end
  end
end
