class Writing < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages
  has_many :transactions
  has_one :correction

  def self.writings_count
    group_by_day(:created_at, last: 7, format: "%b %e").count
  end

  def self.total_writings(user_id)
    where(user_id: user_id).count
  end
end
