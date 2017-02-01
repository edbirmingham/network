$(document).on 'ready page:load', ->
  client = new ZeroClipboard($('.copy_button'))
  $('.copy_button').tooltip()
  
  $('#transport-datetimepicker').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD hh:mm a',
      useCurrent: false
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
