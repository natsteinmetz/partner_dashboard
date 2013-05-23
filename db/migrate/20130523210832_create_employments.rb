class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.references :partner
      t.references :professional
      t.string :role

      t.timestamps
    end
    add_index :employments, :partner_id
    add_index :employments, :professional_id
  end
end
