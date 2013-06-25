class RenameConnectedAttributeInRelationships < ActiveRecord::Migration
  def change
    rename_column :relationships, :connected, :contact_allowed
  end
end
