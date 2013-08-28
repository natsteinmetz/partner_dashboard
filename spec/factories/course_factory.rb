TITLES = ["Rails Bootcamp", "Javascript Night Class", "iOS Bootcamp"]

FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| TITLES[n%TITLES.length] }
    topic "Rails"
    details "The most amazing course in the history of education."
    start_date Date.new(2013, 6, 1)
    end_date Date.new(2013, 6, 30)
  end
end
