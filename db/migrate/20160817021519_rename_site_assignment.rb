class RenameSiteAssignment < ActiveRecord::Migration[5.1]
  def change
    rename_table :site_assignments, :site_contact_assignments
  end
end
