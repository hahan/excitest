FactoryGirl.define do

  factory :user_card do
    name "English to german translation"
    description "English to german translation words"
    user
  end

  factory :user_card_entry1 do
    entry_key "one"
    entry_value "two"
    user_card
  end

  factory :user_card_entry2 do
    entry_key "three"
    entry_value "four"
    user_card
  end

  factory :user do
    name "Hakim"
    email "hakim@hakim.com"
    password "password"
    password_confirmation "password"
  end
end