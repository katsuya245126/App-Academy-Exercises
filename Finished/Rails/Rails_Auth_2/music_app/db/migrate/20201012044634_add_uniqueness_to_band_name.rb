class AddUniquenessToBandName < ActiveRecord::Migration[6.0]
  def change
    add_index :bands, :name, unique: true
  end
end
