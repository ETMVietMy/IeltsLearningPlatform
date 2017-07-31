class Comment < ApplicationRecord
	belongs_to :user
	


	validates :message, presence: true
  
	 def average_rating
	  comments.average(:rating).round(2)
	end
end
