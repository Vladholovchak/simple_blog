class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :user_ip, null: false
      t.string :title, null: false
      t.text :content, null: false
    end
  end
end
