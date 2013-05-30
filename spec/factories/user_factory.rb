FactoryGirl.define do
  factory :user do

    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"

    partner { create(:partner) }

    factory :confirmed_user do
      after(:create) do |user|
        user.confirm!
      end

      factory :admin_user do
        admin true
        partner nil
      end
    end
  end
end
