class UserCard < ActiveRecord::Base
  has_many :user_card_entries
  accepts_nested_attributes_for :user_card_entries

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 120 }

  def entries
    UserCardEntry.where("user_card_id = ?", id)
  end

end
