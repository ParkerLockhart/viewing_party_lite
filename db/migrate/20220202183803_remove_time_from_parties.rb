class RemoveTimeFromParties < ActiveRecord::Migration[5.2]
  def change
    remove_column :parties, :start, :time
  end
end
