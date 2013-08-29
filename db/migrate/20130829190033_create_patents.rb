class CreatePatents < ActiveRecord::Migration
  def change
    create_table :patents do |t|
      t.string :title
      t.text :summary
      t.date :date
      t.string :url
      t.string :inventors
      t.references :profile

      t.timestamps
    end
  end
end
