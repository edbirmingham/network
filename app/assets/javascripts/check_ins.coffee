# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  event_id = $('#network_event_id').val()
  member_level = $('#level').val()
  $('#check_in_button').click ->
    members_to_check_in = $('.check-in-table tbody tr td input:checked').map(->
                            $(this).val()
                          ).get()
    $.ajax({
      type: "POST",
      url: "/network_events/#{event_id}/check_ins/",
      dataType: "json"
      data: { participation: { member_ids: members_to_check_in, network_event_id: event_id, level: member_level} },
      success:(data) ->
        location.href = window.location.href
      error:(data) ->
        return false
    })
  $('.alert').fadeOut(3000)
  $('#check_in_button').prop('disabled', true);

  $('#select-all').click (event) ->
    $('.check-in-table tbody tr td input:checkbox').prop('checked', this.checked)
    toggle_checkin_button()
  $('.check-in-table input:checkbox').click (event) ->
    toggle_checkin_button()

  toggle_checkin_button = ->
    selected_members_count = $('.check-in-table tbody tr td input:checked').size()
    if selected_members_count > 0
      $('#check_in_button').prop('disabled', false);
      $('.info_div').text(selected_members_count + ' members selected.')
    else
      $('#check_in_button').prop('disabled', true);
      $('.info_div').text('')