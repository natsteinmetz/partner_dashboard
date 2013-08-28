require 'spec_helper'

feature "Managing Relationships:" do
  let!(:relationship) { FactoryGirl.create(:pending_relationship) }
  let!(:partner) { relationship.partner }
  let!(:student_user) { relationship.user }
  let!(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    student_user.profile = FactoryGirl.create(:profile)
    student_user.save
    sign_in_as!(admin_user)
    visit '/'
    click_link "Admin"
    click_link "Manage Connections"
  end

  scenario "admin can view all relationships" do
    page.should have_content(partner.name)
    page.should have_content(student_user.profile.name)
  end

  scenario "admin can change a pending connection", js: true do
    page.should have_content("Pending")
    page.should have_content("Connect")
    click_link "Connect"
    page.should have_content("Connected")
    page.should_not have_link("Connect")
    page.should have_link("Destroy")
  end

  scenario "admin can destroy a connection", js: true do
    click_link "Connect"
    click_link "Destroy"
    page.should_not have_content student_user.profile.name
  end

end
