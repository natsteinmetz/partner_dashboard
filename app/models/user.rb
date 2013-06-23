class User < ActiveRecord::Base
  belongs_to :partner

  validates :partner, presence: true, unless: :admin?


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
end
