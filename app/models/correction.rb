class Correction < ApplicationRecord
  belongs_to :writing

  validates :writing_id, uniqueness: true

  # const
  STATUS_NEW = 'new'
  STATUS_DONE = 'done'
  STATUS_ACCEPTED = 'accepted'
  STATUS_DENIED = 'denied'

  # get status
  %w(new done accepted denied).each do |status|
    define_method "#{status}?" do
      status == self.class.const_get("is_#{status.upcase}")
    end
  end

  def get_teacher
    @teacher ||= User.find(teacher_id).teacher
  end

  def get_teacher_account
    @account ||= User.find(teacher_id).account
  end

  def average_score
    
  end

end
