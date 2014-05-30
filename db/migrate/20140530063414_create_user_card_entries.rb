class CreateUserCardEntries < ActiveRecord::Migration
  def change
    create_table :user_card_entries do |t|
      t.string :entry_key
      t.string :entry_value
      t.integer :user_card_id

      t.timestamps
    end
    add_index :user_card_entries, :user_card_id
  end
end
