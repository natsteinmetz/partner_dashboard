class User < ActiveRecord::Base
  belongs_to :partner

  validates :partner, presence: true, unless: :admin?

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :partner_id
  # attr_accessible :title, :body

  def has_contacted?(student)
    if self.admin?
      false
    else
      self.partner.students.include? student
    end
  end
end
