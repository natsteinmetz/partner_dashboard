class InviteRequest
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :first_name, :last_name, :email, :company, :role, :message
  validates :first_name, :last_name, :email, :role, presence: true

  validates_length_of :message, maximum: 500
  #TODO add other validations

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_h
    hash = {}
    self.instance_variables.each do |var|
      hash[var.to_s.delete("@").to_sym]=self.instance_variable_get(var)
    end
    hash
  end

  def persisted?
    false
  end
end
