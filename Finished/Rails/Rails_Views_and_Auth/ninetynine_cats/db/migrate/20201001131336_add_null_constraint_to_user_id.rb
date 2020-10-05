class AddNullConstraintToUserId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :cats, :user_id, false
  end
end
