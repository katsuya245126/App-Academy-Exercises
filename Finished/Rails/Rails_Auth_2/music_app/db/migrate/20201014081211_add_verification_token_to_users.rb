class AddVerificationTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :verification_token, :string, null: false, index: { unique: true }
  end
end
