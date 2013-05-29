FactoryGirl.define do
  factory :professional do
    first_names = ["Larry", "Lauren", "Michael", "Michelle"]
    last_names = ["Laurence", "Michaels", "Mueller", "Smith", "Danger"]
    name {"#{first_names.sample} #{last_names.sample}"}
    phone_number  "555-555-5555"
    email  {"#{name.emailize}@example.com"}
  end
end