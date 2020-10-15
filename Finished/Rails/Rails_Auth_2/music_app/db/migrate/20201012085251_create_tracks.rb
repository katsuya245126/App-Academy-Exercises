class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.references :album, foreign_key: true, null: false
      t.string :title, null: false
      t.integer :ord, null: false
      t.text :lyrics
      t.boolean :bonus, null: false, default: false

      t.timestamps
    end
  end
end
