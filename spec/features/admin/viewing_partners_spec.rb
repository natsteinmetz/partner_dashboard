require 'spec_helper'

feature "Viewing Partners" do
  let!(:partner_one) { FactoryGirl.create(:partner, kind: "BigCo") }
  let!(:partner_two) { FactoryGirl.create(:partner, kind: "Startup") }

  context "without logging in" do
    scenario "Partners link is hidden" do
      visit "/"
      page.should_not have_link("Partners")
    end
  end

  context "as a normal user" do
    let(:user) { FactoryGirl.create(:confirmed_user) }
    scenario "Partners link is hidden" do
      sign_in_as!(user)

      visit "/"
      page.should_not have_link("Partners")
    end
  end

  context "as an admin user" do
    let!(:admin) { FactoryGirl.create(:admin_user) }
    before { sign_in_as!(admin) }

    scenario "they can see the partners", js: true do
      visit "/"
      click_link "Partners"
      click_link "Partners Index"
      page.should have_content partner_one.name
      page.should have_content partner_one.kind

      page.should have_content partner_two.name
      page.should have_content partner_two.kind
    end

    scenario "there is a message when there are no partners", js: true do
      Partner.destroy_all
      visit "/"
      click_link "Partners"
      click_link "Partners Index"
      page.should_not have_content("Partner Name")
      page.should have_content("Sorry, there aren't any partners here yet...")
    end

    scenario "only showing partners of a particular type", js: true do
      visit "/"
      click_link "Partners"
      click_link "Partners Index"
      fill_in "partner-filter", with: partner_one.kind
      page.should have_content partner_one.kind
      page.should_not have_content partner_two.kind
    end

    scenario "admin can sort partners"
  end

end
