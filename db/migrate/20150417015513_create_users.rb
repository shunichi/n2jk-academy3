class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_id
      t.string :name
      t.string :email
      t.string :image
      t.text :auth_hash
      t.boolean :mail_notification
      t.string :nickname
      t.datetime :posts_updated_at

      t.timestamps null: false
    end
    add_index :users, :github_id, unique: true
  end
end
