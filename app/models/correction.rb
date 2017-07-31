include ActionView::Helpers::DateHelper

class Correction < ApplicationRecord
  belongs_to :writing

  validates :writing_id, uniqueness: true

  # const
  STATUS_NEW = 'new'
  STATUS_DONE = 'done'
  STATUS_ACCEPTED = 'accepted'
  STATUS_DENIED = 'denied'
  STATUS_DENY_CONFIRMED = 'deny confirmed'
  STATUS_DENY_REFUSED = 'deny refused'

  # get status
  %w(status_new status_done status_accepted status_denied status_deny_confirmed status_deny_refused).each do |state|
    define_method "is_#{state}?" do
      status == self.class.const_get("#{state.upcase}")
    end
  end

  def get_teacher
    @teacher ||= User.find(teacher_id).teacher
  end

  def get_user_teacher
    @user_teacher ||= User.find(teacher_id)
  end

  def get_user_student
    @user_student ||= self.writing.user
  end

  def get_teacher_account
    @account ||= User.find(teacher_id).account
  end

  def get_last_updated_at
    if !@last_updated_at.nil?
      return @last_updated_at
    else
      if updated_at > Time.now.beginning_of_day
        @last_updated_at = time_ago_in_words(updated_at) + " ago"
      else
        @last_updated_at = updated_at.strftime("%b %d, %Y")
      end
    end
  end

  def average_score
    average = [self.task_achievement, self.coherence_cohesion, self.lexical_resource, self.grammar].reduce(:+).to_f / 4
    (average * 2).ceil / 2.0
  end

end
