# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  event_id = $('#network_event_id').val()
  member_level = $('#level').val()
  $('table :button').click ->
    table_row = $(this).closest("tr")
    row_member_id = $(this).siblings(".row_member_id").val()
    $.ajax({
      type: "POST",
      url: "/network_events/#{event_id}/check_ins/",
      dataType: "json"
      data: { participation: { member_id: row_member_id, network_event_id: event_id, level: member_level} },
      success:(data) ->
        table_row.fadeOut(2000)
      error:(data) ->
        return false
    })
