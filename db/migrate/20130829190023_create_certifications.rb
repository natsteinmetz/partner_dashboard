class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :authority
      t.date :date
      t.references :profile

      t.timestamps
    end
  end
end
