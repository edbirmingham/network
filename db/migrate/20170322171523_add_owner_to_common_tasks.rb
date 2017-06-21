class AddOwnerToCommonTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :common_tasks, :owner, index: true, foreign_key: { to_table: :users }
  end
end
