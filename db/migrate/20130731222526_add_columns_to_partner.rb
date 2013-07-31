class AddColumnsToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :size, :string
    add_column :partners, :website, :string
  end
end
