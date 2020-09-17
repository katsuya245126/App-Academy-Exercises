# frozen_string_literal: true

class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.references :artist, index: true, foreign_key: { to_table: :users }, null: false

      t.index %i[artist_id title], unique: true
      t.timestamps
    end
  end
end
