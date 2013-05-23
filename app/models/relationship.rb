class Relationship < ActiveRecord::Base
  belongs_to :partner
  belongs_to :student

  attr_accessible :status
end
