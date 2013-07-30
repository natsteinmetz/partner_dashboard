class Profile < ActiveRecord::Base
  belongs_to :user

  #linkedin_link and summary are coming from LinkedIn API, the other attributes come are provided by Code Fellows data import
  attr_accessible :email, :first_name, :github_link, :last_name, :linkedin_link, :personal_website_link, :phone_number, :summary

end

