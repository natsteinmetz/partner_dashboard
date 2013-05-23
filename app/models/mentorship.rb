class Mentorship < ActiveRecord::Base
  belongs_to :professional
  belongs_to :student
  attr_accessible :current
end
