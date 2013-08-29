class Skill < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :name
  validates :name, uniqueness: true
end
