class Professional < ActiveRecord::Base
  has_many :partners, :through => :employments
  has_many :employments

  has_many :students, :through => :mentorships
  has_many :mentorships

  attr_accessible :email, :name, :phone_number, :employments_attributes, :bio, :links

  accepts_nested_attributes_for :employments

  validates :email, :name, presence: true
end
