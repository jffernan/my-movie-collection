class User < ActiveRecord::Base
  has_secure_password #enable sessions to use bcrypt
  has_many :movies
end
