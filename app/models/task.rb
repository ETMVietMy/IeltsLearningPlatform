class Task < ApplicationRecord
	# has_many :tasks
  has_many :attachments, as: :attached_item, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }

  def attachment
    self.attachments.first
  end
end
