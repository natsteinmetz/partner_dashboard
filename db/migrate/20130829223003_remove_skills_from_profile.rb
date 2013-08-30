class RemoveSkillsFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :skills
  end

  def down
    add_column :profiles, :skills, :string
  end
end
