class Student < ActiveRecord::Base
  has_many :professionals, :through => :mentorships
  has_many :mentorships
  has_many :partners, :through => :relationships
  has_many :relationships
  attr_accessible :email, :name, :phone_number, :skill
end

