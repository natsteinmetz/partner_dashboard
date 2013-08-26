class ModifyEnrollments < ActiveRecord::Migration
  def up
    change_table :enrollments do |t|
      t.remove :student_id
      t.references :user
    end
    add_index :enrollments, :user_id
  end

  def down
    change_table :enrollments do |t|
      t.references :student
      t.remove :user_id
    end
    add_index :enrollments, :student_id
  end
end
