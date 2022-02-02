class RemoveUserFromParties < ActiveRecord::Migration[5.2]
  def change
    remove_reference :parties, :user, foreign_key: true
  end
end
