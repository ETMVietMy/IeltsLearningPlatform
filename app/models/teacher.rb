class Teacher < ApplicationRecord
  belongs_to :user
  has_many :follows
  has_many :comments

  validates :experience, :nationality, :price, presence: true
  validates :price, numericality: true

  

  def self.search(params)
    joins(:user)
      .where("username ILIKE ? AND nationality ILIKE ?",
                  "%#{params[:username]}%",
                  "%#{params[:nationality]}%"
                  )
  end

end
