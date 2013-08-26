class ModifyEmployments < ActiveRecord::Migration
  def up
    change_table :employments do |t|
      t.remove :professional_id
      t.references :user
      t.rename :role, :title
    end
    add_index :employments, :user_id
  end

  def down
    change_table :employments do |t|
      t.references :professional
      t.remove :user_id
      t.rename :title, :role
    end
    add_index :employments, :professional_id
  end
end
