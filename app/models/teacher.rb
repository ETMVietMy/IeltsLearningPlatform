class Teacher < ApplicationRecord
  belongs_to :user
  has_many :follows
  has_many :comments, dependent: :destroy

  has_many :ratings

  validates :experience, :nationality, :price, presence: true
  validates :price, numericality: true

  def self.search(params)
    joins(:user)
      .where("username ILIKE ? AND nationality ILIKE ?",
                  "%#{params[:username]}%",
                  "%#{params[:nationality]}%"
                  )
  end

  def average_rating
  ratings.sum(:score) / ratings.size
end

end
