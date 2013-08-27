class Relationship < ActiveRecord::Base
  belongs_to :partner
  belongs_to :user

  attr_accessible :connection_allowed, :partner_id, :user_id
  validates_uniqueness_of :partner_id, scope: :user_id

  #Make a pending relationship between a partner and user
  def self.pending(partner_id, student_id)
    new(partner_id: partner_id,
        user_id: student_id,
        connection_allowed: false)
  end

  def self.pending!(partner_id, student_id)
    pending(partner_id, user_id).save
  end

  #Make a connected relationship between a partner and user
  def self.connection_allowed(partner_id, student_id)
    new(partner_id: partner_id,
        user_id: student_id,
        connection_allowed: true)
  end

  def self.connection_allowed!(partner_id, student_id)
    connection_allowed(partner_id, student_id).save
  end

  def pending?
    self.connection_allowed? ? false : true
  end
end
