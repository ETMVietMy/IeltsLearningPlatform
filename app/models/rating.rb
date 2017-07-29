class Rating < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  def average_rating
  ratings.sum(:score) / ratings.size
end
end
