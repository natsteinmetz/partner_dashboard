class AddColumnsToProfessional < ActiveRecord::Migration
  def change
    add_column :professionals, :bio, :text
    add_column :professionals, :links, :string
  end
end
