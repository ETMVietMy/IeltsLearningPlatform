class Writing < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages
  has_one :correction
end
