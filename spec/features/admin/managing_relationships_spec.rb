require 'spec_helper'

feature "Managing Relationships:" do
  let!(:relationship) { FactoryGirl.create(:pending_relationship) }
  let!(:partner) { relationship.partner }
  let!(:student) { relationship.student }
  let!(:admin) { FactoryGirl.create(:admin_user) }

  before do
    sign_in_as!(admin)
    visit '/'
    click_link "Manage Relationships"
  end

  scenario "admin can view all relationships" do
    page.should have_content(partner.name)
    page.should have_content(student.name)
  end

  scenario "admin can change a pending connection" do
  end

  scenario "admin can destroy a connection" do
  end

  scenario "admin can make a new connection" do
  end
end
