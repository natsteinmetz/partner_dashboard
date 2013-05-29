class ChangePhoneNumberAttributeForProfessionals < ActiveRecord::Migration
  def up
    remove_column :professionals, :phone_number
    add_column :professionals, :phone_number, :string
  end

  def down
    remove_column :professionals, :phone_number
    add_column :professionals, :phone_number, :integer
  end
end
