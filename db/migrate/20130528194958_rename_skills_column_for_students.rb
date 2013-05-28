class RenameSkillsColumnForStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.rename :skill, :skills
    end
  end
end
