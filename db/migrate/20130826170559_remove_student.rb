class RemoveStudent < ActiveRecord::Migration
  def up
    drop_table :students

    change_table :users do |t|
      t.remove :student_id
    end
  end

  def down
    create_table :students do |t|
      t.string   "name"
      t.string   "email"
      t.text     "skills"
      t.string   "phone_number"
      t.boolean  "for_hire"
      t.text     "bio"
      t.string   "links"

      t.timestamps
    end

    add_column :users, :student_id, :integer
  end
end
