class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments

  attr_accessible :details, :end_date, :start_date, :title, :topic
end
