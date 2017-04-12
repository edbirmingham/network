$(document).on 'ready page:load', ->
  client = new ZeroClipboard($('.copy_button'))
  $('.copy_button').tooltip()
  
  $('#transport-datetimepicker').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD hh:mm a',
      useCurrent: false
    })
    
  $('#event-task-datetimepicker').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD hh:mm a'
     }) 
  
  checked = $('#network_event_needs_transport').is(':checked')
  if checked
    $('#order_div').show()
  else
    $('#order_div').hide()
    
  $('#network_event_needs_transport').change ->
    $('#order_div').slideToggle()
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
    $("#create-task-button").html("Hide Form")
    $("#create-task-button").on "click", ->
      $("#new-task-form").hide()
      
    