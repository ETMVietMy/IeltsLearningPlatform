class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :teacher

	validates :message, presence: true
  

  
 def average_rating
  ratings.sum(:score) / ratings.size
end

  
	
end
