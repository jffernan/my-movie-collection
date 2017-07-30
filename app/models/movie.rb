class Movie < ActiveRecord::Base
  belongs_to :user #1 Movie is owned (bought) by 1 User

  def self.alphabetical_order #ActiveRecord method to alphabetize lists
    Movie.order(title: :asc)
  end
end
