class AddHostToPartyUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :party_users, :host, :boolean
  end
end
