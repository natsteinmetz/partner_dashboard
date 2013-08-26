class User < ActiveRecord::Base
  #has_one :profile
  rolify

  has_many :courses, through: :enrollments
  has_many :enrollments

  has_many :company_connections, :through => :relationships, source: :partner
  has_many :relationships

  has_many :employers, :through => :employments, source: :partner
  has_many :employments

  # non-admins must have a partner
#  validates :partner, presence: true, unless: :admin?

  # get_invite_requests can't be true unless admin
  validates :get_invite_requests, exclusion: { in: [true],
    message: "Only admin users can receive invite requests" }, unless: :is_admin?


  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :partner_id, :get_invite_requests


  # def requested_connection?(person)
  #   if self.has_role? :admin
  #     false
  #   elsif self.has_role? :professional
  #     all_self.partners.first.users.include? person
  #   elsif self.has_role? :student
  #     self.partners.include? person
  #   else
  #     "NEVER"
  #   end
  # end

  # def connected?(person)
  #   if self.admin?
  #     true
  #   elsif self.is_partner? && (self.partner.students.include? person)
  #     self.partner.relationships.find_by_student_id(person.id).connection_allowed
  #   elsif self.is_student? && (self.student.partners.include? person)
  #     #TODO: Can't figure out how to make this line not hit the database, even if i eager load relationships.
  #     self.student.relationships.find_by_partner_id(person.id).connection_allowed
  #   else
  #     false
  #   end
  # end

private
  # hack to make the validation work for get_invite_requests
  def is_admin?
    self.has_role? :admin
  end

end
