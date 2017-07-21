include ActionView::Helpers::DateHelper

class Message < ApplicationRecord
  has_many :recipients
  validates :sender, presence: true
  validates :content, :subject, presence: true

  accepts_nested_attributes_for :recipients

  def writing
  end

  def is_request?
    self.message_type == 'req'
  end

  def getSender
    @user ||= User.find_by(id: sender)
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
