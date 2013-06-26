class User < ActiveRecord::Base
  belongs_to :partner

  validates :partner, presence: true, unless: :admin?

  # get_invite_requests can't be true unless admin
  validates :get_invite_requests, exclusion: { in: [true],
    message: "Only admin users can receive invite requests" }, unless: :admin?


  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :partner_id

  def has_contacted?(student)
    if self.admin?
      false
    else
      self.partner.students.include? student
    end
  end

  def connected?(student)
    if self.admin?
      true
    elsif self.partner.students.include? student
      #TODO: Can't figure out how to make this line not hit the database, even if i eager load relationships.
      self.partner.relationships.find_by_student_id(student.id).contact_allowed ? true : false
    else
      false
    end
  end
end
