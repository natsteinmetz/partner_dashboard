class Partner < ActiveRecord::Base
  has_many :professionals, :through => :employments
  has_many :employments

  has_many :students, :through => :relationships
  has_many :relationships

  has_many :users

  attr_accessible :kind, :name
end
