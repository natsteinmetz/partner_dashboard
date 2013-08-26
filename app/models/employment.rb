class Employment < ActiveRecord::Base
  belongs_to :partner
  belongs_to :user

  attr_accessible :role, :partner_id
  validates :role, presence: true
end
