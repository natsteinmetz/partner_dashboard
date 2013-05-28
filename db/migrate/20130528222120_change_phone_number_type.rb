class ChangePhoneNumberType < ActiveRecord::Migration
  def up
    remove_column :students, :phone_number
    add_column :students, :phone_number, :string
  end

  def down
    remove_column :students, :phone_number
  add_column :students, :phone_number, :integer
  end
end
