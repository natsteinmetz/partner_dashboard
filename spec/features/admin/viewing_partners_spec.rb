require 'spec_helper'

feature "Viewing Partners" do
  let!(:partner_one) { FactoryGirl.create(:partner) }
  let!(:partner_two) { FactoryGirl.create(:partner) }

  context "without logging in" do
    scenario "Partners link is hidden"
  end

  context "as a normal user" do
    scenario "Partners link is hidden"
  end

  context "as an admin user" do
    let!(:admin) { FactoryGirl.create(:admin_user) }

    scenario "they can see the partners" do
      sign_in_as!(admin)

      visit "/"
      click_link "Partners"
      page.should have_content partner_one.name
      page.should have_content partner_one.kind

      page.should have_content partner_two.name
      page.should have_content partner_two.kind
    end
  end

end
