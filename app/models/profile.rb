class Profile < ActiveRecord::Base
  belongs_to :user

  before_filter :authenticate_user!

  #linkedin_link and summary are coming from LinkedIn API, the other attributes come are provided by Code Fellows data import
  attr_accessible :email, :first_name, :github_link, :last_name, :linkedin_link, :personal_website_link, :phone_number, :summary

  validates :email, :first_name, :last_name, :phone_number, :linkedin_link, :github_link, :summary, presence: true

  def first_name_last_name
    :first_name + " " + :last_name
  end

  def last_name_first_name
    :last_name + " " + :first_name
  end

end

