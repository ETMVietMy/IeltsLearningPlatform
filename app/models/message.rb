include ActionView::Helpers::DateHelper

class Message < ApplicationRecord
  has_many :recipients
  validates :sender, presence: true
  validates :content, :subject, presence: true

  accepts_nested_attributes_for :recipients

  # define constant for message_type
  TEXT_MESSAGE = 'msg'
  REQUEST = 'req'
  CORRECTION = 'cor'
  NOTIFICATION = 'not'

  %w(text_message request correction notification).each do |state|
    define_method "#{state}?" do
      message_type == self.class.const_get(state.upcase)
    end
  end

  def self.total_unread_message(user_id)
    joins(:recipients).where('recipients.user_id = ? and is_read = ?', user_id, false).count
  end

  def writing
  end

  def is_request?
    self.message_type == REQUEST
  end

  def getSenderEmail
    if self.message_type!=NOTIFICATION
      @user ||= User.find_by(id: sender).email
    else
      "System Notification"
    end
  end

  def getSenderName
    if self.message_type!=NOTIFICATION
      @user ||= User.find_by(id: sender).name
    else
      "System Admin"
    end
  end

  def getRecipient
    @recipient ||= User.find_by(id: Recipient.where(message_id: id).map(&:user_id))
  end

  def getSentAt
    if !@sent_at.nil?
      return @sent_at
    else
      if created_at > Time.now.beginning_of_day
        @sent_at = time_ago_in_words(created_at) + " ago"
      else
        @sent_at = created_at.strftime("%b %d, %Y")
      end
    end
  end

end
