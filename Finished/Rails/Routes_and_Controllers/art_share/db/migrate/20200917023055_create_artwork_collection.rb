class CreateArtworkCollection < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_collections do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :artwork, null: false, foreign_key: true

      t.timestamps
    end
  end
end
