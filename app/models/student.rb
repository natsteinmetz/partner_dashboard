class Student < ActiveRecord::Base
  attr_accessible :email, :name, :phone_number, :skill
end
