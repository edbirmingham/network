$(document).on 'ready page:load turbolinks:load', ->
  client = new ZeroClipboard($('.clip_button'))
  $('.clip_button').tooltip()
  
  # initialize gem for inplace editing
  $('.best_in_place').best_in_place()
  
  $('#transport-datetimepicker').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD hh:mm a',
      useCurrent: false
    })
    
  $('#event-task-datetimepicker').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD hh:mm a'
     }) 
  
  needs_transport = $('#network_event_needs_transport').val()
  if needs_transport == 'true'
    $('#order_div').show()
  else
    $('#order_div').hide()
    
  $('#network_event_needs_transport').change ->
    needs_transport = $('#network_event_needs_transport').val()
    if needs_transport == 'true'
      $('#order_div').show()
    else
      $('#order_div').hide()
      
  $('#event-datetimepicker').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD hh:mm a',
      useCurrent: false
  })
  
  $('#network_event_transport_ordered_on').val("")
  
  $('.task-chk').change ->
    if $(this).is(':checked')
      $(this).parent().parent().find(':input').filter('.task-field').prop("disabled", false)
    else
      $(this).parent().parent().find(':input').filter('.task-field').prop("disabled", true)
      
  $("#new-task-form").hide()
  $("#create-task-button").on "click", ->
    $("#new-task-form").show()
    $("#create-task-button").hide()
      
    
  # Task completion on event show page
  $('tr.network_event_task').on 'ajax:success', (event, data) ->
    if data.completed_at
      $(this).children('td.task_completed_at').html(data.completed_at)
      $(this).children("td.task_mark").find(".task_button").replaceWith("Completed");
      $("#completed-count").text( parseInt( $("#completed-count").text() ) + 1);