class RemoveProfessional < ActiveRecord::Migration
  def up
    drop_table :professionals
  end

  def down
    create_table "professionals" do |t|
      t.string   "name"
      t.string   "email"
      t.string   "phone_number"
      t.text     "bio"
      t.string   "links"

      t.timestamps
    end
  end
end
