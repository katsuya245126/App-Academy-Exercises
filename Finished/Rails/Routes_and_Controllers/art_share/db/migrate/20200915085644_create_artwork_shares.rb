# frozen_string_literal: true

class CreateArtworkShares < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_shares do |t|
      t.references :artwork, index: true, foreign_key: true, null: false
      t.references :viewer, index: true, foreign_key: { to_table: :users }, null: false

      t.index %i[artwork_id viewer_id], unique: true
      t.timestamps
    end
  end
end
