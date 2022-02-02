class RemoveDayFromParties < ActiveRecord::Migration[5.2]
  def change
    remove_column :parties, :day, :date
  end
end
