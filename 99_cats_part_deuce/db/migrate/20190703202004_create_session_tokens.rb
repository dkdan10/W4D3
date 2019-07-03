class CreateSessionTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :session_tokens do |t|
      t.string :session_token, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :session_tokens, :user_id
    add_index :session_tokens, :session_token, unique: true
    remove_index :users, :session_token
    remove_column :users, :session_token
  end
end
