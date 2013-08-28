class ModifyRelationships < ActiveRecord::Migration
  def up
    change_table :relationships do |t|
      t.remove :student_id
      t.references :user
    end
    add_index :relationships, :user_id
  end

  def down
    change_table :relationships do |t|
      t.references :student
      t.remove :user_id
    end
    add_index :relationships, :student_id
  end
end
