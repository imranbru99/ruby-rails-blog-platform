class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :excerpt
      t.boolean :published, null: false, default: false
      t.datetime :published_at
      t.boolean :featured, null: false, default: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, :published
    add_index :posts, :featured
  end
end
