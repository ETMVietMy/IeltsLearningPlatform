class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :teacher

  
 def average_rating
  ratings.sum(:score) / ratings.size
end

  
	
end
