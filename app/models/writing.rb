class Writing < ApplicationRecord
  belongs_to :task
  belongs_to :user, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :correction, dependent: :destroy

  # constants
  STATUS_NEW = 'new'
  STATUS_REQUESTED = 'requested'
  STATUS_CORRECTING = 'correcting'
  STATUS_CORRECTED = 'corrected'
  STATUS_ACCEPTED = 'accepted'
  STATUS_DENIED = 'denied'

  # methods
  def self.writings_count
    group_by_day(:created_at, last: 7, format: "%b %e").count
  end

  def self.total_writings(user_id)
    where(user_id: user_id).count
  end

  def change_status(status)
    self.update_attributes(status: status) if %w(new requested correcting corrected accepted denied).include? status
  end

  def can_view_correction?
    %w(corrected accepted denined).include? self.status
  end

  def can_request?
    %w(new).include? self.status
  end
end
