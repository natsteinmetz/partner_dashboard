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
        email "admin@codefellows.com"
        partner nil
        get_invite_requests true
      end

      factory :student_user do
        partner nil
        student 
      end
    end
  end
end
