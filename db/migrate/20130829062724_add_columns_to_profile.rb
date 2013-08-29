class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :headline, :string
    add_column :profiles, :languages, :string
    add_column :profiles, :last_modified_timestamp, :datetime
  end
end
