class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :teacher
  has_one  :account
  has_many :follows
  has_many :ratings


  has_many :comments, dependent: :destroy
  has_many :writings
  has_many :tasks
  has_many :recipients

  validates :username, presence: true

  ROLE_TEACHER = "TCH"
  ROLE_STUDENT = "STD"
  ROLE_ADMIN = "ADM"

  def name_or_username
    self.name.presence || self.username
  end

  def self.teachers
    where(role: self::ROLE_TEACHER)
  end

  def rating
    5
  end

  def corrections
    return nil if self.is_student?

    Correction.where(teacher_id: self.id)
  end

  def is_student?
    self.role == ROLE_STUDENT
  end

  def is_teacher?
    self.role == ROLE_TEACHER
  end

  def getAllFollowedTeachers
    @follow_teachers ||= Teacher.where(id: Follow.where(user_id: id).map(&:teacher_id))
  end

  def isFollowing(teacher_id)
    !Follow.find_by(user_id: id, teacher_id: teacher_id).nil?
  end

  # messages
  def received_messages
    @received_messages ||= Message.where(id: self.recipients.map(&:message_id), hide_recipient: false).order("created_at desc")
          #  .where.not(sender: getAllBlockCases).order("created_at desc")
  end

  def unread_messages
    @unread_messages ||= received_messages.select{|message| message.is_read == false}
  end

  def read_messages
    @read_messages ||= received_messages.select{|message| message.is_read == false}
  end

  def sent_messages
    @sent_message ||= Message.where(sender: id, hide_sender: false).order("created_at desc")
  end

  def self.getAllTeacherUser()
    @users ||= User.where(role: "TCH")
  end

end
