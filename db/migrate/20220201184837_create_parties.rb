class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.integer :movie_id
      t.integer :duration
      t.date :day
      t.time :start
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
