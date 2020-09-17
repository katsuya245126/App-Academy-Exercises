class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :likeable, polymorphic: true

      t.timestamps
    end
  end
end
