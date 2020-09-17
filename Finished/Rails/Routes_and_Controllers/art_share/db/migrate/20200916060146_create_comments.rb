class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :artwork, index: true, foreign_key: true, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
