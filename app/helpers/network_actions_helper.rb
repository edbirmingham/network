module NetworkActionsHelper
  def action_button_name(action)
    if action.new_record?
      'Create Action'
    else
      'Update Action'
    end
  end
end
