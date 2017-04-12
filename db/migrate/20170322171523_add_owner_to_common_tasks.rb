class AddOwnerToCommonTasks < ActiveRecord::Migration
  def change
    add_reference :common_tasks, :owner, index: true, foreign_key: true
  end
end
