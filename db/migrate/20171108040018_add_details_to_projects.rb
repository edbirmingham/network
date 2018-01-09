class AddDetailsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :due_date, :date
    add_column :projects, :completed_at, :date
  end
end
