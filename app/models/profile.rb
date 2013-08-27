class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone_number, :summary, :skills, :linkedin_link, :github_link, :personal_website_link, :for_hire, :admin_notes

  belongs_to :user

  validates :first_name, :last_name, presence: true

end
