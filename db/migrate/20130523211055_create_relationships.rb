class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :partner
      t.references :student
      t.string :status

      t.timestamps
    end
    add_index :relationships, :partner_id
    add_index :relationships, :student_id
  end
end
