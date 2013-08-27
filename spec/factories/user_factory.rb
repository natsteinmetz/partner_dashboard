FactoryGirl.define do
  factory :user do

    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"

#    partner

    factory :confirmed_user do
      after(:create) do |user|
        user.confirm!
      end

      factory :admin_user do
        email "admin@codefellows.com"

        after(:create) do |user|
          user.add_role :admin
          user.update_attributes(get_invite_requests: true)
          user.save
        end
      end

      factory :student_user do
        after(:create) do |user|
          user.add_role :student
        end
      end

      factory :student_user_with_courses do
        after(:create) do |user|
          user.add_role :student
          user.course(FactoryGirl.new(:course))
        end
      end

      factory :professional_user do
        after(:create) do |user|
          user.add_role :professional
        end
      end
    end

  end
end
