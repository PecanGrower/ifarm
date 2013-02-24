FactoryGirl.define do
  factory :company do
    name "Big Pecan Farm"
  end
  factory :user do
    email "Michael@Example.com"
    password "foobar"
    password_confirmation "foobar"
    company
  end
  factory :farm do
    name "North Acreage Farm"
    company
  end
end