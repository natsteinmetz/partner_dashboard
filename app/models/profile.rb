class Profile < ActiveRecord::Base

  attr_accessible :first_name, :last_name, :phone_number, :summary, :skills, :linkedin_link, :github_link, :personal_website_link, :for_hire, :admin_notes, :headline, :languages, :last_modified_timestamp

  belongs_to :user

  has_many :skills
  has_many :positions
  has_many :publications
  has_many :patents
  has_many :educations
  has_many :volunteers
  has_many :certifications

  validates :first_name, :last_name, presence: true

  def name
    first_name + " " + last_name
  end

  # build profile from LinkedIn data
  def build_profile
    response = full_profile_call
    set_summary(response)
    set_headline(response)
    set_languages(response)
    set_timestamp(response)
    build_nested_elements(response)
    self.save
  end

  def build_nested_elements(response)
    skills.set_skills(response)
    positions.set_positions(response)
    publications.set_publications(response)
    patents.set_patents(response)
    educations.set_educations(response)
    volunteers.set_volunteers(response)
    certifications.set_certifications(response)
  end

  # check to see whether LinkedIn profile has changed,
  # if yes, rebuild profile
  def check_profile_timestamp(user)
    response = check_timestamp_call(user)
    date = DateTime.strptime(response["person"]["last_modified_timestamp"], '%s')
    if date != self.last_modified_timestamp
      build_profile
    end
  end

private
  def full_profile_call
    fields = ":(headline,summary,skills,three-current-positions,three-past-positions,volunteer,educations,certifications,patents,publications,languages,last-modified-timestamp)"
    api_call(fields, user.token)
  end

  def check_timestamp_call(checked_user)
    fields = ":(last-modified-timestamp)"
    api_call(fields, checked_user.token)
  end

  # LinkedIn API call
  def api_call(fields, token)
    api_url = "https://api.linkedin.com/v1/people/~"+fields+"?oauth2_access_token="+token
    response = HTTParty.get(api_url)
  end

  def set_summary(response)
    self.summary = response["person"]["summary"]
  end

  def set_headline(response)
    self.headline = response["person"]["headline"]
  end

  def set_languages(response)
    self.languages = ""
    response["person"]["languages"]["language"].each do |t|
      if self.languages != "" then self.languages << ", " end
      self.languages << t["language"]["name"]
    end
  end

  def set_timestamp(response)
    self.last_modified_timestamp = DateTime.strptime(response["person"]["last_modified_timestamp"], '%s')
  end

end
