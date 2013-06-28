class ChangeContactAllowedAttributeToConnectionAllowedInRelationships < ActiveRecord::Migration
  def change
    rename_column :relationships, :contact_allowed, :connection_allowed
  end
end
