class CreateDislikes < ActiveRecord::Migration[5.2]
  def change
    create_table :dislikes do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true

      t.timestamps
    end
    add_index :dislikes, [:user_id, :message_id], unique: true
  end
end
