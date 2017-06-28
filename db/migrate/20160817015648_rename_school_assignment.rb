class RenameSchoolAssignment < ActiveRecord::Migration[5.1]
  def change
    rename_table :school_assignments, :school_contact_assignments
  end
end
