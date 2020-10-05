class AddNullConstraintToUserIdCatRentalRequest < ActiveRecord::Migration[6.0]
  def change
    change_column_null :cat_rental_requests, :user_id, false
  end
end
