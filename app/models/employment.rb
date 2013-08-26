class Employment < ActiveRecord::Base
  belongs_to :partner
  belongs_to :user

  attr_accessible :title, :partner_id
  validates :title, presence: true
end
