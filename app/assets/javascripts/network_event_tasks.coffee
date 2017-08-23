$(document).on 'ready page:load turbolinks:load', ->
  # initialize and link datepickers
  $ ->
    $('#startdatepicker').datetimepicker
      useCurrent: false
      format: 'ddd MMMM DD YYYY'
    $('#enddatepicker').datetimepicker
      useCurrent: false
      format: 'ddd MMMM DD YYYY'
    $('#startdatepicker').on 'dp.change', (e) ->
      $('#enddatepicker').data('DateTimePicker').minDate e.date
      return
    $('#enddatepicker').on 'dp.change', (e) ->
      $('#startdatepicker').data('DateTimePicker').maxDate e.date
      return
    return
    
  # Task completion
  $('tr.network_event_task').on 'ajax:success', (event, data) ->
    $(this).children('td.completed_at').html(data.completed_at)
    $(this).children("td.task_completed").find(".completed_button").replaceWith("Completed")
    
  #In-place editing
  $.fn.editable.defaults.mode = 'inline'
  $('.task-name').editable
    name: 'name'
    resource: 'network_event_task'
    type: 'text'
  $('.task-owner').editable
    name: 'owner_id'
    resource: 'network_event_task'
    type: 'select'
  
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
      url: "/network_event_tasks/#{task_id}/"
      dataType: "json"
      data: { network_event_task: { due_date: new_date } }
      context: this
      success:(data) ->
        formatted_date = moment(data.due_date).format('ddd, MMMM D YYYY')
        $(this).parents('.date-form').hide()
        $(this).parents('.date-form').siblings('.date-view').text(formatted_date).show()
      error:(data) ->
        alert 'error updating due date'
    })
    
    
    
    
