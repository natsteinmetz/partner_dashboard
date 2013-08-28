require 'spec_helper'

feature 'viewing professionals' do
  let!(:professional_one) { FactoryGirl.create(:partner_with_professional,
    name: "Acme", kind: "BigCo").users.first }
  let!(:professional_two) { FactoryGirl.create(:partner_with_professional,
    name: "Facebook", kind: "Startup").users.first }

  context "as an admin user" do
    let!(:admin) { FactoryGirl.create(:admin_user) }

    before { sign_in_as!(admin) }

    scenario "user is redirected to manager relationships page upon signing in" do
      page.should have_content("Manage Connections")
    end

    scenario "there is a message when there are no professionals" do
      all_professionals = User.with_role :professional
      all_professionals.each do |prof|
        prof.destroy
      end
      visit "/"
      click_link "Professionals Index"

      page.should_not have_content("Professional Name")
      page.should have_content("Sorry, there aren't any professionals here yet...")
    end

    scenario "professionals view contains all the professionals and their partner" do
      visit '/admin/professionals'
      page.should have_content "Code Fellows Company Professionals"
      [professional_one,
       professional_two].each do |professional|

        # needs to be updated after user profiles are created
        #page.should have_content(professional.name)
        page.should have_content(professional.partner.name)
      end
    end

    scenario "user can filter professionals by partner name", :js => true do
      visit '/'
      click_link "Partners"
      click_link "Professionals Index"
      fill_in "professional-filter", with: professional_one.partner.name
      #needs to be updated after user profiles are created
      #page.should have_content professional_one.name
      #page.should_not have_content professional_two.name
    end

    scenario "user can sort professionals by ____"
  end

end
