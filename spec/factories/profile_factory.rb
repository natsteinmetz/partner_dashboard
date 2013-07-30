FactoryGirl.define do
  factory :profile do
    first_name "Nathalie"
    last_name "Steinmetz"
    email "student@example.com"
    phone_number "(555) 555-5555"
    summary "Saved the world from alien invasion."
    linkedin_link "http://linkedin.com/in/nathaliesteinmetz"
    github_link "https://github.com/natsteinmetz"
    personal_website_link "http://nathaliesteinmetz.net"

    courses do
      Array(1..2).sample.times.map { FactoryGirl.create(:course) }
    end
  end
end
