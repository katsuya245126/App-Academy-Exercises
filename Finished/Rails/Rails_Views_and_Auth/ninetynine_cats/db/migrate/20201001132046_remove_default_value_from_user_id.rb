class RemoveDefaultValueFromUserId < ActiveRecord::Migration[6.0]
  def change
    change_column_default :cats, :user_id, nil
  end
end
