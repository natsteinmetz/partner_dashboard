class Skill < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :linkedin_id, :name
  validates :name, uniqueness: true
end
