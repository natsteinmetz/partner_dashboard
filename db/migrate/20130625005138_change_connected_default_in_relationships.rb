class ChangeConnectedDefaultInRelationships < ActiveRecord::Migration
  def change
    change_column :relationships, :connected, :boolean, :default => false
  end
end
