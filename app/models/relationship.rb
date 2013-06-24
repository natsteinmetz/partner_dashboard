class Relationship < ActiveRecord::Base
  belongs_to :partner
  belongs_to :student

  attr_accessible :connected, :partner_id, :student_id

  #Make a pending relationship between a partner and user
  def self.pending(partner_id, student_id)
    new(partner_id: partner_id,
        student_id: student_id,
        connected: false)
  end

  def self.pending!(partner_id, student_id)
    pending(partner_id, student_id).save
  end

  #Make a connected relationship between a partner and user
  def self.connected(partner_id, student_id)
    new(partner_id: partner_id,
        student_id: student_id,
        connected: true)
  end

  def self.connected!(partner_id, student_id)
    connected(partner_id, student_id).save
  end

  def pending?
    self.connected? ? false : true
  end
end
