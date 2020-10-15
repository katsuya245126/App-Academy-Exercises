class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :track, foreign_key: true, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
