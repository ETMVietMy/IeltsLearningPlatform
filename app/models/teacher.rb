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

  def self.random_teachers
    User.teachers.order("RANDOM()").limit(3)
  end

end
