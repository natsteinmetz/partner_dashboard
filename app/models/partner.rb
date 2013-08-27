class Partner < ActiveRecord::Base
  attr_accessible :kind, :name, :professionals_attributes, :employments_attributes,
    :size, :website, :technologies, :about

  has_many :users

  has_many :students, :through => :relationships, source: :user
  has_many :relationships

  # accepts_nested_attributes_for :user, :employments

  validates :name, :kind, :website, presence: true
  validates :name, uniqueness: true
end
