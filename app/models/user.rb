class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :teacher
  has_many :follows
  has_many :writings
  has_many :tasks

  validates :username, presence: true

  def is_student?
    self.role == 'STD'
  end

  def is_teacher?
    self.role == 'TEC'
  end

  def getAllFollowedTeachers
    @teachers = Teacher.where(id: Follow.where(user_id: id).map(&:teacher_id))
  end

  def isFollowing(teacher_id)
    !Follow.find_by(user_id: id, teacher_id: teacher_id).nil?
  end

end
