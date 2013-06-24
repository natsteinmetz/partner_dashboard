class AddForHireToStudents < ActiveRecord::Migration
  def change
    add_column :students, :for_hire, :boolean
  end
end
