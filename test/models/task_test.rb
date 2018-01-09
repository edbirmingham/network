require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "should not save task without name" do
    task = Task.new()
    assert_not task.save
  end
  
  test "should save task with name" do
    task = Task.new(name: 'Test Task')
    assert task.save
  end
  
  test "should mark subtask completed when parent task is completed" do
    time = Time.local(2016, 8, 2, 10, 5, 0)
    task = Task.new(name: 'Test task', due_date: time)
    subtask = Task.new(name: "Test subtask", date_modifier: "Day before", parent_id: task.id)
    task.save
    task.update(completed_at: Time.now)
    assert_not nil, subtask.completed_at
    assert Time.local(2016, 8, 1), subtask.completed_at
  end
  
end