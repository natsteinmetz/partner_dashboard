class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :users, through: :enrollments

  attr_accessible :details, :end_date, :start_date, :title, :topic
end
