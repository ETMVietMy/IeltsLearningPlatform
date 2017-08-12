class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :teacher
  has_one  :account
  has_many :follows
  has_one :attachment, as: :attached_item, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :writings
  has_many :tasks
  has_many :recipients
  has_many :messages, through: :recipients

  validates :username, presence: true

  ROLE_TEACHER = "TCH"
  ROLE_STUDENT = "STD"
  ROLE_ADMIN = "ADM"

  # scope
  scope :teachers, -> { where(role: ROLE_TEACHER) }

  # functions

  def name_or_username
    if self.name.present?
      return self.name
    else
      return self.username
    end
  end

  def self.teachers
    where(role: self::ROLE_TEACHER)
  end

  # avatar
  def has_avatar?
    self.attachment.present?
  end

  def avatar_url
    self.attachment.attachment.url
  end
  #end avatar

  # information
  def unread_messages_count
    self.messages.where(is_read: false).count
  end

  def teacher_info
    self.teacher
  end

  def average_rating
    self.comments.average(:rating) || 0
  end

  #writing
  def writing_stat
    Writing.writings_count(self.id)
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

  def is_admin?
    self.role == ROLE_ADMIN
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

  def self.getUserEmailAndAccount(current_user_email)
    @users_accounts ||= User.joins(:account).where('role NOT LIKE ? AND email NOT LIKE ?', ROLE_ADMIN, current_user_email)
                   .select('accounts.id as account_id, users.email')
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
    @users ||= User.where(role: ROLE_TEACHER)
  end

end
