class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :role
      t.string :organization
      t.references :profile

      t.timestamps
    end
  end
end
