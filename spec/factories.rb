FactoryGirl.define do
  factory :company do
    name "Big Pecan Farm"
  end
  factory :user do
    name "Michael Hartl"
    email "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
    company
  end
end