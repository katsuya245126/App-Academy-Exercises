class AddVerificationToUserEmail < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :activated, :boolean, default: false, null: false
  end
end
