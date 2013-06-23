class Partner < ActiveRecord::Base
  attr_accessible :kind, :name, :professionals_attributes, :employments_attributes
  has_many :professionals, :through => :employments
  has_many :employments

  has_many :students, :through => :relationships
  has_many :relationships

  has_many :users

  accepts_nested_attributes_for :professionals, :employments



  validates :name, :kind, presence: true
  validates :name, uniqueness: true
end
