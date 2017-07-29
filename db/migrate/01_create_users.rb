class CreateUsers < ActiveRecord::Migrations[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest #need for bcrypt password authentication
    end
  end
end
