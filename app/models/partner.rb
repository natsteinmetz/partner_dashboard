class Partner < ActiveRecord::Base
  attr_accessible :kind, :name, :professionals_attributes, :employments_attributes,
    :size, :website, :technologies, :about

  has_many :users, :through => :employments
  has_many :employments

  has_many :users, :through => :relationships
  has_many :relationships

  has_many :users

  accepts_nested_attributes_for :users, :employments


  validates :name, :kind, :website, presence: true
  validates :name, uniqueness: true
end
