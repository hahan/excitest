class UserCard < ActiveRecord::Base
  extend FriendlyId
  friendly_id :id_and_name, :use => [:slugged, :finders]

  belongs_to :user
  
  default_scope -> { order('created_at ASC') }

  has_many :user_card_entries
  accepts_nested_attributes_for :user_card_entries

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 120 }

  def id_and_name
    "#{user_id} #{name}"
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def entries
    UserCardEntry.where("user_card_id = ?", id)
  end

end
