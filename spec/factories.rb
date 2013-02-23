FactoryGirl.define do
  factory :company do
    name "Big Pecan Farm"
  end
  factory :user do
    email "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
    company
  end
end