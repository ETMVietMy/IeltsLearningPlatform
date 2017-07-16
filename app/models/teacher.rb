class Teacher < ApplicationRecord
  belongs_to :user
  has_many :follows

  def self.search(params)
    joins(:user)
      .where("username ILIKE ? AND nationality ILIKE ?",
                  "%#{params[:username]}%",
                  "%#{params[:nationality]}%"
                  )
  end

end
