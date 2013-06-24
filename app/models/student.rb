class Student < ActiveRecord::Base
  has_many :professionals, :through => :mentorships
  has_many :mentorships

  has_many :partners, :through => :relationships
  has_many :relationships

  has_many :courses, through: :enrollments
  has_many :enrollments

  attr_accessible :email, :name, :phone_number, :skills
end

