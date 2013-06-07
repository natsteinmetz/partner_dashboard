require 'spec_helper'

feature "Inviting potential users" do
  invitee_name = "invitee"
  invitee_email = "invitee@example.com"
  invitee_password = "password"
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:partner) { FactoryGirl.create(:partner) }

  #TODO, create_potential_user returns a hash, but i'd like an object with attributes, couldn't
  #figure out a way to include class files in specs
  let!(:potential_user) { create_potential_user }

  context "Visitor Requests Invite" do
    before do
      request_invite(potential_user)
      sign_in_as!(admin)
    end

    scenario "Admin receives an email when an invite is requested" do
      email = open_email admin.email, :with_subject => /would like to be added/
      potential_user.each do |key, value|
        email.should have_content(value)
      end
    end

  end



  scenario "admin can send a user an invitation and assign him/her to a particular partner" do
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
    assert(partner == invited_user.partner, "The invited user is not associated with the correct partner.
                                             User's partner is : #{invited_user.partner.name}
                                             and the test partner is: #{partner.name}")
  end

  #TODO, I think this scenario needs to be moved into the invitations controller spec
  scenario "normal user cannot send an invitation"

  scenario "admin can create a brand new partner in an invitation form"
end
