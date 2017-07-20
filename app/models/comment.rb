class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :teacher

  has_many :ratings
  

  
	
end
