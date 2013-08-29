class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :field
      t.date :start_date
      t.date :end_date
      t.string :degree
      t.references :profile

      t.timestamps
    end
  end
end
