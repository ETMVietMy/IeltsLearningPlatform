class Comment < ApplicationRecord
	belongs_to :user
	


	validates :message, presence: true
  
	 def average_rating
	  ratings.sum(:score) / ratings.size
	end
end
