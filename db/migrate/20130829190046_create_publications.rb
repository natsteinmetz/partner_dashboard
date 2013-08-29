class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.string :publisher
      t.string :authors
      t.date :date
      t.string :url
      t.text :summary
      t.references :profile

      t.timestamps
    end
  end
end
