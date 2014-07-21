class AddSlugToUserCards < ActiveRecord::Migration
  def change
    add_column :user_cards, :slug, :string
    add_index :user_cards, :slug
  end
end
