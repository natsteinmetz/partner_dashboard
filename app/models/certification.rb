class Certification < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :name, :authority, :date
end
