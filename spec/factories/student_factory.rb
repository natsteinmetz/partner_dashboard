FactoryGirl.define do
  factory :student do
    name "Jane Doe"
    email "student@example.com"
    phone_number "(555) 555-5555"
    skills "javascript, c++, ruby"
    for_hire false
    bio "Saved the world from alien invasion."
    links "https://api.github.com/users/mojombo"

    courses do
      Array(1..2).sample.times.map { FactoryGirl.create(:course) }
    end
  end
end
