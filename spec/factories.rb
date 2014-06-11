FactoryGirl.define do
  factory :user_card do
    name "English to german translation"
    description "English to german translation words"
  end

  factory :user do
    name "Hakim"
    email "hakim@hakim.com"
    password "password"
    password_confirmation "password"
  end
end