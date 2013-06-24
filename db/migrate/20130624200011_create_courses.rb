class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :topic
      t.text :details

      t.timestamps
    end
  end
end
