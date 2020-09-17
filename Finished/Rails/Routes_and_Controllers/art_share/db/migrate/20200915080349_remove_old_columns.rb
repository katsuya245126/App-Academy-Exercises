# frozen_string_literal: true

class RemoveOldColumns < ActiveRecord::Migration[5.2]
  def change
    remove_columns(:users, :name, :email)
  end
end
