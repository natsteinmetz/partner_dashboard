require 'spec_helper'

feature "Inviting potential users:" do
  invitee_name = "invitee"
  invitee_email = "invitee@example.com"
  invitee_password = "password"
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:partner) { FactoryGirl.create(:partner) }

  #TODO, create_potential_user returns a hash, but i'd like an object with attributes, couldn't
  #figure out a way to include class files in specs

  let!(:invite_request) { create_invite_request company: partner.name }

  context "Visitor Requests Invite:" do
    before do
      request_invite(invite_request)
      sign_in_as!(admin)
    end

    scenario "Admin receives an email to invite a potential user when an invite is requested" do
      email = open_email admin.email, with_subject: /would like to be added/
      invite_request.each do |key, value|
        email.should have_content value
      end
      email.should have_content "Go to Dashboard"
    end

    scenario "Admin follows invite request link to a populated invite form" do
      follow_invite_request_link(admin)
      invite_request.each do |key,value|
        page.should have_content value
      end
      find_field("Email").value.should eq invite_request[:email]
      find_field("user_partner_id").find('option[selected]').text.should eq invite_request[:company]
      page.should have_button "Send an invitation"
    end

    scenario "Admin can create a new partner on the form and assign the invitee to it.", js: true do
      follow_invite_request_link(admin)
      click_link "Partner not listed?"

    end
  end



  scenario "Admin can send an invitation to an email address" do
    #in context of admin
    sign_in_as!(admin)
    click_link "Invite A New User"

    #TODO, apparently this select tag is named incorrectly, it should be something like partner[partner_id]
    select partner.name, :from => "user[partner_id]"
    fill_in "Email", :with => invitee_email
    click_button "Send an invitation"

    #TODO, this is ugly, Need to sign out as admin or i'll get redirected when I accept the invitation,
    click_link "Sign out"

    #in context of invited user
    open_email "invitee@example.com", :with_subject => /Invitation instructions/
    visit_in_email "Accept invitation"
    fill_in "Password", :with => invitee_password
    fill_in "Password confirmation", :with => invitee_password
    click_button "Set my password"
    invited_user = User.find_by_email(invitee_email)
    assert(invited_user.partner == partner, "The invited user is not associated with the correct partner.
                                             User's partner is : #{invited_user.partner}
                                             and the test partner is: #{partner.name}")
  end

  #TODO, I think this scenario needs to be moved into the invitations controller spec
  scenario "normal user cannot send an invitation"

  scenario "admin can create a brand new partner in an invitation form"
end
