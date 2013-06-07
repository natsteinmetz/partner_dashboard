module PotentialUserHelpers

  def create_potential_user args={}
    defaults = {
      :first_name    => "John",
      :last_name    => "Smith",
      :role => "Hiring Manager",
      :company => "Acme",
      :message => "Please add me to the partner dashboard.",
      :email => "johnsmith@acme.com"
    }
    args.reverse_merge(defaults)
  end

  def request_invite(user)
    visit '/'
    click_link "Request Invitation"
    fill_in "Email", with: user[:email]
    fill_in "First Name", with: user[:first_name]
    fill_in "Last Name", with: user[:last_name]
    fill_in "Company", with: user[:company]
    fill_in "Role", with: user[:role]
    fill_in "Message to Admin", with: user[:message]
    click_button "Submit"
  end
end


RSpec.configure do |c|
  c.include PotentialUserHelpers, :type => :feature
end