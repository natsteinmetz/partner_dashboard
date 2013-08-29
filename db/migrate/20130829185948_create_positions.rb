class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.text :summary
      t.date :start_date
      t.date :end_date
      t.string :string
      t.references :profile

      t.timestamps
    end
  end
end
