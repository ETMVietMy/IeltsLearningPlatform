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

end
