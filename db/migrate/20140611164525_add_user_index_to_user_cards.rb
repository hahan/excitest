class AddUserIndexToUserCards < ActiveRecord::Migration
  def change
    add_column :user_cards, :user_id, :integer
  end
end
