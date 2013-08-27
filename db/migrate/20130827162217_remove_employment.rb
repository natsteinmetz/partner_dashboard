class RemoveEmployment < ActiveRecord::Migration
  def up
    drop_table :employments
  end

  def down
    create_table :employments do |t|
      t.references :partner
      t.references :user
      t.string :title

      t.timestamps
    end
    add_index :employments, :partner_id
    add_index :employments, :user_id
  end
end
