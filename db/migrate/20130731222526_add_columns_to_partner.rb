class AddColumnsToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :size, :string
    add_column :partners, :website, :string
    add_column :partners, :technologies, :string
    add_column :partners, :about, :text
  end
end
