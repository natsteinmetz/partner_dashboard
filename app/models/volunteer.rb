class Volunteer < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :role, :organization
end
