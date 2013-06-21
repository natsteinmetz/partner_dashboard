module AdminHelpers
  def follow_invite_request_link(admin_user)
    open_email admin_user.email, with_subject:  /would like to be added/
    visit_in_email "Go to Dashboard"
  end
end

RSpec.configure do |c|
  c.include AdminHelpers, type: :feature
end