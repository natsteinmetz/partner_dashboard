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
    set_skills(response)
    set_positions(response)
    set_educations(response)
    # set_certifications(response)
    # set_publications(response)
    # set_patents(response)
    # set_volunteers(response)
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

  # convenience method for the view
  def get_all_skills
    skills = ""
    self.skills.each do |skill|
      if skills != "" then skills << ", " end
      skills << skill.name
    end
    skills
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
    return if response["person"]["summary"] == nil
    self.summary = response["person"]["summary"]
  end

  def set_headline(response)
    self.headline = response["person"]["headline"]
  end

  def set_languages(response)
    self.languages = ""
    return if response["person"]["languages"] == nil
    response["person"]["languages"]["language"].each do |t|
      if self.languages != "" then self.languages << ", " end
      self.languages << t["language"]["name"]
    end
  end

  def set_timestamp(response)
    self.last_modified_timestamp = DateTime.strptime(response["person"]["last_modified_timestamp"], '%s')
  end

  def set_skills(response)
    return if response["person"]["skills"] == nil
    existing_skills = Skill.where("linkedin_id = ? and profile_id = ?", response["id"], self.id)
    unless existing_skills.blank?
      existing_skills.each do |skill|
        skill.destroy
      end
    end
    response["person"]["skills"]["skill"].each do |t|
      self.skills << Skill.create(linkedin_id: t["id"], name: t["skill"]["name"])
    end
  end

  def set_positions(response)
    set_current_positions(response)
    set_past_positions(response)
  end

  def set_current_positions(response)
    return if response["person"]["three_current_positions"]["total"] == "0"
    response["person"]["three_current_positions"]["position"].each do |t|
      pos = Position.where("linkedin_id = ? and profile_id = ?", t["id"], self.id)
      pos.first.destroy unless pos.blank?
      start_d = Date.new(t["start_date"]["year"].to_i, t["start_date"]["month"].to_i,1)
      self.positions << Position.create(linkedin_id: t["id"], title: t["title"], summary: t["summary"], start_date: start_d, company: t["company"]["name"] )
    end
  end

  def set_past_positions(response)
    return if response["person"]["three_past_positions"]["total"] == "0"
    response["person"]["three_past_positions"]["position"].each do |t|
      pos = Position.where("linkedin_id = ? and profile_id = ?", t["id"], self.id)
      pos.first.destroy unless pos.blank?
      start_d = Date.new(t["start_date"]["year"].to_i, t["start_date"]["month"].to_i,1)
      end_d = Date.new(t["end_date"]["year"].to_i, t["end_date"]["month"].to_i, 1)
      self.positions << Position.create(linkedin_id: t["id"], title: t["title"], summary: t["summary"], start_date: start_d, end_date: end_d, company: t["company"]["name"])
    end
  end

  def set_educations(response)
    return if response["person"]["educations"] == nil
    response["person"]["educations"]["education"].each do |t|
      edu = Education.where("linkedin_id = ? and profile_id = ?", t["id"], self.id)
      edu.first.destroy unless edu.blank?
      start_d = Date.new(t["start_date"]["year"].to_i, 1, 1)
      if t["end_date"] == nil
        self.educations << Education.create(linkedin_id: t["id"], school_name: t["school_name"], field: t["field_of_study"], start_date: start_d, degree: t["degree"])
      else
        end_d = Date.new(t["end_date"]["year"].to_i, 1, 1)
        self.educations << Education.create(linkedin_id: t["id"], school_name: t["school_name"], field: t["field_of_study"], start_date: start_d, end_date: end_d, degree: t["degree"])
      end
    end
  end

  def set_certifications(response)
  end

  def set_publications(response)
  end

  def set_patents(response)
  end

  def set_volunteers(response)
  end

end
