require 'spec_helper'

feature 'viewing professionals' do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }

  scenario "A signed in admin user is redirected to partners index upon signing in" do
    visit '/users/sign_in'
    fill_in "Email", :with => admin.email
    fill_in "Password", :with => admin.password
    page.should have_content ("Partners Index")
  end

end
