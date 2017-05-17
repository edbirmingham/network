class AddDateModiferToCommonTasks < ActiveRecord::Migration
  def change
    add_column :common_tasks, :date_modifier, :string
  end
end
