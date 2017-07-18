class Attachment < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  belongs_to :attached_item, polymorphic: true 

  validates_presence_of :attachment
  # validates_integrity_of :attachment


  # Callbacks
  before_save :update_attachment_attributes

  # Virtual attributes
  alias_attribute :filename, :original_filename

  private
  def update_attachment_attributes
    if attachment.present? && attachment_changed?
      self.original_filename = attachment.file.original_filename
      # self.content_type = attachment.file.content_type
    end
  end
end
