class RenameSchoolAssignment < ActiveRecord::Migration
  def change
    rename_table :school_assignments, :school_contact_assignments
  end
end
