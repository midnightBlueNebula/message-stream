class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :confirmed, default: false
      t.boolean :admin, default: false
      t.boolean :online, default: false
      t.boolean :locked, default: false
      t.boolean :banned, default: false
      t.boolean :isolated, default: false
      t.integer :karma, default: 0

      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :email, unique: true 
  end
end
