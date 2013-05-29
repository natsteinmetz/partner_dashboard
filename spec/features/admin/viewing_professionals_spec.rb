require 'spec_helper'

feature 'viewing professionals' do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:professional_one) { FactoryGirl.create(:partner_with_professional).professionals.first }
  let!(:professional_two) { FactoryGirl.create(:partner_with_professional).professionals.first }
  let!(:professional_three) { FactoryGirl.create(:partner_with_professional).professionals.first }

  scenario "An admin user is redirected to professionals index upon signing in" do
    visit '/users/sign_in'
    fill_in "Email", :with => admin.email
    fill_in "Password", :with => admin.password
    click_button "Sign in"
    page.should have_content("Code Fellows Company Professionals")
  end

  scenario "An admin user's professionals view contains all the professionals and their partner" do
    sign_in_as!(admin)
    visit '/admin/professionals'
    page.should have_content "Code Fellows Company Professionals"
    [professional_one,
     professional_two,
     professional_three].each do |professional|

      page.should have_content(professional.name)

      professional.partners.each do |partner|
        page.should have_content(partner.name)
      end

    end
  end
end
