FactoryGirl.define do
  factory :user do

    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"

    partner

    factory :confirmed_user do
      after(:create) do |user|
        user.confirm!
      end

      factory :admin_user do
        admin true
        email ADMIN_EMAIL
        partner nil
      end
    end
  end
end
