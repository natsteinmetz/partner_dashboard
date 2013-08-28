require "spec_helper"

feature "editing professional details" do
  before do
    @professional = FactoryGirl.create(:professional_user)
    @partner = FactoryGirl.create(:partner)
    @professional.partner = @partner
    @professional.save
    @professional_two = FactoryGirl.create(:professional_user)
    @professional_two.partner = @partner
    @professional_two.save
  end

  context "as a professional/partner" do
    before do
      sign_in_as!(@professional)
      click_link "My Company"
    end

    scenario "can edit own information" do
      click_link @professional.profile.name
      page.should have_content(@professional.email)
      page.should have_content(@professional.profile.phone_number)
      click_link "Edit Profile"
      fill_in "First name", with: "Lady Gaga"
      fill_in "Last name", with: "the Great"
      click_button "Update Profile"
      page.should have_content "Lady Gaga the Great"
    end

    scenario "cannot edit information for other professionals in own company" do
      click_link @professional_two.profile.name
      page.should have_content(@professional_two.email)
      page.should_not have_content "Edit Profile"
    end
  end

  context "as a student" do
    scenario "cannot edit professional profile info" do
      student = FactoryGirl.create(:student_user)
      sign_in_as!(student)
      click_link "Partners"
      click_link @partner.name
      page.should have_content(@professional.profile.name)
      click_link @professional.profile.name
      page.should_not have_content("Edit Profile")
    end
  end

  context "as an admin" do
    scenario "can edit any profile info" do
      admin = FactoryGirl.create(:admin_user)
      sign_in_as!(admin)
      click_link "Partners"
      click_link "Partners Index"
      click_link @partner.name
      page.should have_content(@partner.about)
      page.should have_content("Edit Profile")
      click_link "Edit Profile"
      fill_in "About", with: "This company has been included in The Best Places To Work in Seattle"
      click_button "Update Partner"
      page.should have_content("This company has been included in The Best Places To Work in Seattle")
    end
  end
end
