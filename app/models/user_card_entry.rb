class UserCardEntry < ActiveRecord::Base
  belongs_to :user_card

  validates :entry_key, presence: true, length: { maximum: 50 }
  validates :entry_value, presence: true, length: { maximum: 100 }
end
