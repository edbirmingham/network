# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load turbolinks:load', ->
  $('#toggle_cohort_status').click ->
    cohort_id = $('#cohort_id').val()
    cohort_status = (($('#cohort_status').val() == "true") ? true : false)
    $.ajax({
      type: "PUT",
      url: "/cohorts/#{cohort_id}",
      dataType: "json"
      data: { cohort: { active: !cohort_status } },
      success:(data) ->
      	$('#cohort_status').val data.active
      	if data.active
      	  $('#cohort_status_label').text 'Active'
      	  $('#toggle_cohort_status').text 'Deactivate'
      	else
      	  $('#cohort_status_label').text 'Deactive'
      	  $('#toggle_cohort_status').text 'Activate'
      error:(data) ->
        return false
    })
