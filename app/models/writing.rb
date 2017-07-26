class Writing < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages
  has_many :transactions
  has_one :correction

  def self.writings_count
    where('created_at >= ?', 1.week.ago ).group('Date(created_at)').select('count(*) as count, DATE(created_at) as date')
  end
end
