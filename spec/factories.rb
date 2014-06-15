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
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end

  end
end