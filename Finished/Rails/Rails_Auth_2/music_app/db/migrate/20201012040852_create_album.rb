class CreateAlbum < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.references :band, foreign_key: true, null: false
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :live, null: false, default: false

      t.timestamps
      t.index [:band_id, :title], unique: true
    end
  end
end
