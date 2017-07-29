class Movie < ActiveRecord::Base
  belongs_to :user

  def self.alphabetical_order #ActiveRecord method to alphabetize lists
    Movie.order(title: :asc)
  end
end
