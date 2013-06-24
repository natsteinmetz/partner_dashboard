class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :course
      t.references :student

      t.timestamps
    end
    add_index :enrollments, :course_id
    add_index :enrollments, :student_id
  end
end
