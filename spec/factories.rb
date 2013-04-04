FactoryGirl.define do
  
  factory :company do
    sequence(:name) { |n| "Company #{n}" }
  end

  factory :weather_station do
    sequence(:name) { |n| "Station #{n}" }
    sequence(:db_col) { |n| "station_#{n}" }
    sequence(:id_code) { |n| "nmcc-da-#{n}" }
  end

  factory :user do
    sequence(:email) { |n| "User_#{n}@Example.com" }
    password "foobar"
    password_confirmation "foobar"
    company
  end

  factory :farm do
    sequence(:name) { |n| "Farm #{n}" }
    weather_station_id 1
  end

  factory :irrigation_well do
    sequence(:name) { |n| "Pump #{n}" }
    sequence(:pod_code) { |n| "lrg-#{12345+n}-pod1" }
    # farm
  end

  factory :block do
    sequence(:name) { |n| "Block #{n}" }
    farm
  end

  factory :field do
    sequence(:name) { |n| "Field #{n}" }
    acreage 9.8
    soil_class_id 1
    block
  end

  factory :irrigation do
    time Time.now
    field
  end


end