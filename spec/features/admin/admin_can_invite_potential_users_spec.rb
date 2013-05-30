require 'spec_helper'

feature "admin can invite potential users" do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }

  scenario "admin can access the admin invitation" do
    sign_in_as!(admin)
    click_link "Invite A New User"
  end

  scenario "normal user cannot access the admin invitation" do
  end

  scenario "admin can select an existing partner in invitation form" do
  end

  scenario "admin can create a brand new partner in an invitation form" do
  end

  scenario "admin can send an invitation" do
  end

end