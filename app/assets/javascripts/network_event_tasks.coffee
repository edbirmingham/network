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
    
  $('tr.network_event_task').on 'ajax:success', (event, data) ->
    $(this).children('td.completed_at').html(data.formatted_date)
    
    
