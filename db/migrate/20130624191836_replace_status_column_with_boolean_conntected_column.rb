class ReplaceStatusColumnWithBooleanConntectedColumn < ActiveRecord::Migration
  def up
    remove_column :relationships, :status
    add_column :relationships, :connected, :boolean
  end

  def down
    remove_column :relationships, :connected
    add_column :relationships, :status, :string
  end
end
