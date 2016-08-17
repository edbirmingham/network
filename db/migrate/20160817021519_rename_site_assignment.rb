class RenameSiteAssignment < ActiveRecord::Migration
  def change
    rename_table :site_assignments, :site_contact_assignments
  end
end
