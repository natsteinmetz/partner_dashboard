require 'spec_helper'

feature 'viewing professionals index' do
  let!(:partner) { FactoryGirl.create(:partner_with_professional) }
  let!(:professional) { partner.users.first }
  let!(:professional_2) { FactoryGirl.create(:professional_user) }
  let!(:partner_2) { FactoryGirl.create(:partner_with_professional) }

  before do
    partner.users << professional_2
    professional.profile = FactoryGirl.create(:profile)
    professional.save
    professional_2.profile = FactoryGirl.create(:profile)
    professional_2.save
  end


  context "as an admin user" do
    let!(:admin) { FactoryGirl.create(:admin_user) }

    before { sign_in_as!(admin) }

    scenario "there is a message when there are no professionals" do
      all_professionals = User.with_role :professional
      all_professionals.each do |prof|
        prof.destroy
      end
      visit "/"
      click_link "Professionals"

      page.should_not have_content("Professional Name")
      page.should have_content("Sorry, there aren't any professionals here yet...")
    end

    scenario "contains all the professionals with their partner" do
      visit '/admin/professionals'
      page.should have_content "Code Fellows Company Professionals"
      [professional, professional_2].each do |professional|
        page.should have_content(professional.profile.name)
        page.should have_content(professional.partner.name)
      end
    end

    scenario "can filter professionals by partner name", :js => true do
      partner_2.users.first.profile = FactoryGirl.create(:profile)

      visit '/'
      click_link "Professionals"
      fill_in "professional-filter", with: professional.partner.name

      page.should have_content professional.profile.name
      page.should_not have_content partner_2.users.first.profile.name
    end

    scenario "can filter professionals by name", js: true do
      visit '/'
      click_link "Professionals"
      fill_in "professional-filter", with: professional.profile.name

      page.should have_content professional.profile.name
      page.should_not have_content professional_2.profile.name
    end

    scenario "can filter professionals by email", js: true do
      visit '/'
      click_link "Professionals"
      fill_in "professional-filter", with: professional.email[0..6]

      page.should have_content professional.profile.name
      page.should_not have_content professional_2.profile.name
    end
  end
end
