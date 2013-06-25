class AddAttributesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :bio, :text
    add_column :students, :links, :string
  end
end
