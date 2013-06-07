#TODO, I need to change this into a factory
module InviteRequestsHelpers

  def create_invite_request args={}
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

  def request_invite(invite_request)
    visit '/'
    click_link "Request Invitation"
    fill_in "Email", with: invite_request[:email]
    fill_in "First Name", with: invite_request[:first_name]
    fill_in "Last Name", with: invite_request[:last_name]
    fill_in "Company", with: invite_request[:company]
    fill_in "Role", with: invite_request[:role]
    fill_in "Message to Admin", with: invite_request[:message]
    click_button "Submit"
  end
end


RSpec.configure do |c|
  c.include InviteRequestsHelpers, :type => :feature
end