$(document).on 'ready page:load', ->
  $('#confirm').hide()
  $('#parent').hide()
  $('#member_ids').on 'select2:select', (e) ->
    $('#participation_member_id').val(e.params.data.id)
    $('#create').hide()
    $('#member_ids').html()
    $('#confirm').show()
    $('#first_name').text(e.params.data.first_name)
    $('#last_name').text(e.params.data.last_name)
    $('#phone').text(e.params.data.phone)
    $('#email').text(e.params.data.email)
  $('#unconfirm').on 'click', ->
    $('#confirm').hide()
    $('#create').show()
  $('#member_identity').on 'select2:select', (e) ->
    selected = e.params.data.text
    if selected is 'Student'
      $('#student').show() 
      $('#parent').hide() 
    else if selected is 'Parent' or selected is 'Educator'
      $('#parent').show() 
      $('#student').hide() 
    else
      $('#parent').hide() 
      $('#student').hide() 