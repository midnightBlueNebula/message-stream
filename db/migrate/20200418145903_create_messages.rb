class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :karma, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
