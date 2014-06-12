class UserCard < ActiveRecord::Base
  belongs_to :user
  
  default_scope -> { order('created_at ASC') }

  has_many :user_card_entries
  accepts_nested_attributes_for :user_card_entries

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 120 }

  def entries
    UserCardEntry.where("user_card_id = ?", id)
  end

end
