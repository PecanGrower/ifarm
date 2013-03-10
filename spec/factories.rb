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
  end

  factory :block do
    sequence(:name) { |n| "Block #{n}" }
    farm
  end

  factory :field do
    sequence(:name) { |n| "Field #{n}" }
    acreage 9.8
    block
  end
end