class AddIndexesToUsers < ActiveRecord::Migration
  def change
  end
  add_index :users, :partner_id
  add_index :users, [:invited_by_id, :invited_by_type]
end
