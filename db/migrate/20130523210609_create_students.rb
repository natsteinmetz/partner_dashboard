class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.integer :phone_number
      t.string :email
      t.text :skill

      t.timestamps
    end
  end
end
