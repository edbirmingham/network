class AddActiveToCohorts < ActiveRecord::Migration[5.1]
  def change
    add_column :cohorts, :active, :boolean, default: true
  end
end
