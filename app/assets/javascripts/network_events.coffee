$(document).on 'ready page:load turbolinks:load', ->
  client = new ZeroClipboard($('.clip_button'))
  $('.clip_button').tooltip()
  
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
      
  #In-place editing
  $('a.event-name').editable
    name: 'name'
    resource: 'network_event'
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
      
      
  