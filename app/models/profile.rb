class Profile < ActiveRecord::Base
  require 'json'

  attr_accessible :first_name, :last_name, :phone_number, :summary, :skills, :linkedin_link, :github_link, :personal_website_link, :for_hire, :admin_notes

  belongs_to :user

  validates :first_name, :last_name, presence: true

  def name
    first_name + " " + last_name
  end

  # build profile from LinkedIn data
  def build_profile
    pretty_string = JSON.pretty_generate(response)
    hash = JSON.parse(pretty_string)
    binding.pry

  end

  def response
    fields = ":(headline,summary,skills,three-current-positions,three-past-positions,volunteer,educations,patents,publications,languages,last-modified-timestamp)"
    api_url = "https://api.linkedin.com/v1/people/~"+fields+"?oauth2_access_token="+user.token
    response = HTTParty.get(api_url)
  end

end
