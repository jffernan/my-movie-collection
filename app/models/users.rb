class User < ActiveRecord::Base
  has_secure_password #enable sessions to use bcrypt
  has_many :movies

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug) #class method to slug username when has space
    User.all.find{|user| user.slug == slug}
  end

end
