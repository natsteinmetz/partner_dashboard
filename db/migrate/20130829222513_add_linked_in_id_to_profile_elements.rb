class AddLinkedInIdToProfileElements < ActiveRecord::Migration
  def change
    add_column :certifications, :linkedin_id, :integer
    add_column :educations, :linkedin_id, :integer
    add_column :patents, :linkedin_id, :integer
    add_column :positions, :linkedin_id, :integer
    add_column :skills, :linkedin_id, :integer
    add_column :publications, :linkedin_id, :integer
    add_column :volunteers, :linkedin_id, :integer
  end
end
