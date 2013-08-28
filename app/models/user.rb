class User < ActiveRecord::Base
  #has_one :profile
  rolify

  has_many :courses, through: :enrollments
  has_many :enrollments

  has_many :company_connections, :through => :relationships, source: :partner
  has_many :relationships

  belongs_to :partner

  has_one :profile
  accepts_nested_attributes_for :profile

  # get_invite_requests can't be true unless admin
  validates :get_invite_requests, exclusion: { in: [true],
    message: "Only admin users can receive invite requests" }, unless: :is_admin?


  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :partner_id, :get_invite_requests, :profile_attributes


  def requested_connection?(entity)
    if self.has_role? :admin
      false
    elsif self.has_role? :professional
      self.partner.students.include? entity
    elsif self.has_role? :student
      self.company_connections.include? entity
    else
      "NEVER"
    end
  end

  def connected?(entity)
    if self.has_role? :admin
      true
    # self is a professional user, entity is a student user
    elsif (self.has_role? :professional) && (self.partner.students.include? entity)
      self.partner.relationships.where(user_id: entity.id).first.connection_allowed
    # self is a student user, entity is a partner company
    elsif (self.has_role? :student) && (self.company_connections.include? entity)
      #TODO: Can't figure out how to make this line not hit the database, even if i eager load relationships.
      self.relationships.find_by_partner_id(entity.id).connection_allowed
    else
      false
    end
  end

private
  # hack to make the validation work for get_invite_requests
  def is_admin?
    self.has_role? :admin
  end

end
