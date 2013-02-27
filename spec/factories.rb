FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "Company #{n}" }
  end
  factory :user do
    sequence(:email) { |n| "User_#{n}@Example.com" }
    password "foobar"
    password_confirmation "foobar"
    company
  end
  factory :farm do
    sequence(:name) { |n| "Farm #{n}" }
    company
  end
end