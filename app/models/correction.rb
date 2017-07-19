class Correction < ApplicationRecord
  belongs_to :writing

  validates :writing_id, uniqueness: true
end
