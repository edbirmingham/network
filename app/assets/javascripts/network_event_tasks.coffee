$(document).on 'ready page:load', ->
  
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
    
  # initialize bip for inplace editing
  $('.best_in_place').best_in_place()

  # Task completion
  $('tr.network_event_task').on 'ajax:success', (event, data) ->
    $(this).children('td.completed_at').html(data.completed_at)
    $(this).children("td.task_completed").find(".completed_button").replaceWith("Completed")

    
