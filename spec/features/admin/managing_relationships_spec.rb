require 'spec_helper'

feature "Managing Relationships:" do
  let!(:relationship) { FactoryGirl.create(:pending_relationship) }
  let!(:partner) { relationship.partner }
  let!(:student_user) { relationship.user }
  let!(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    sign_in_as!(admin_user)
    visit '/'
    click_link "Manage Connections"
  end

  scenario "admin can view all relationships" do
    page.should have_content(partner.name)
    #page.should have_content(student_user.name)
  end

  scenario "admin can change a pending connection" do
  end

  scenario "admin can destroy a connection" do
  end

  scenario "admin can make a new connection" do
  end
end
