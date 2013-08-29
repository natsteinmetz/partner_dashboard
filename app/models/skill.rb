class Skill < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :name
end
