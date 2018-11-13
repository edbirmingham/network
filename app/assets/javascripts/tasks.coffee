
$(document).on 'turbolinks:load', ->
  # initialize and link datepickers
  $ ->
    $('#startdatepicker').datetimepicker
      useCurrent: false
      format: 'ddd MMMM DD YYYY'
    $('#enddatepicker').datetimepicker
      useCurrent: false
      format: 'ddd MMMM DD YYYY'
    $('#task-datetimepicker').datetimepicker 
      format: 'ddd MMMM DD YYYY'
    $('#startdatepicker').on 'dp.change', (e) ->
      $('#enddatepicker').data('DateTimePicker').minDate e.date
      return
    $('#enddatepicker').on 'dp.change', (e) ->
      $('#startdatepicker').data('DateTimePicker').maxDate e.date
      return
    return
    
  #In-place editing
  $.fn.editable.defaults.mode = 'inline'
  
  $('.task-name').editable
    name: 'name'
    resource: 'task'
    type: 'text'
    
  $('.task-owner').editable
    name: 'owner_id'
    resource: 'task'
    type: 'select'
    
  # In-place editing that requires popups instead of inline
  $('.task-name-pop').editable
    mode: 'popup'
    name: 'name'
    resource: 'task'
    type: 'text'
  
  $('.date-form').hide()
  $('.cancel-update').on 'click', ->
    $(this).parents('.date-form').hide()
    $(this).parents('.date-form').siblings('.date-view').show()
    
  #allow date textbox to come up
  $('.date-view').on 'click', ->
    $(this).hide()
    $(this).siblings().show()
    
  $('.update-due-date').on 'click', ->
    task_id = $(this).parent().parent().data('task-id')
    date_input = $(this).parent().parent().children('.date-input').val()
    new_date = new Date(date_input + " CST")
    new_date.setHours(23,59,59,999)
    $.ajax({
      type: "PATCH",
      url: "/tasks/#{task_id}/"
      dataType: "json"
      data: { task: { due_date: new_date } }
      context: this
      success:(data) ->
        formatted_date = moment(data.due_date).format('ddd, MMMM D YYYY')
        $(this).parents('.date-form').hide()
        $(this).parents('.date-form').siblings('.date-view').text(formatted_date).show()
      error:(data) ->
        alert 'error updating due date'
    })
  
  $.fn.attachTaskButtonListener = ->
    this.on 'click', (e) ->
      $(this).parent().siblings('.js-task-fields').toggle()
      $(this).html (i, html) ->
        if html == 'Add task' then 'Hide form' else 'Add task'
        
  $.fn.attachSubtaskButtonListener = ->
    this.on 'click', (e) ->
      $(this).parent().find('.js-subtask-fields').toggle()
      $(this).html (i, html) ->
        if html == 'Add subtask' then 'Hide form' else 'Add subtask'
    
  $('.js-show-task-btn').attachTaskButtonListener()
  $('.js-show-subtask-btn').attachSubtaskButtonListener()
    