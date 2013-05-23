class CreateMentorships < ActiveRecord::Migration
  def change
    create_table :mentorships do |t|
      t.references :professional
      t.references :student
      t.boolean :current

      t.timestamps
    end
    add_index :mentorships, :professional_id
    add_index :mentorships, :student_id
  end
end
