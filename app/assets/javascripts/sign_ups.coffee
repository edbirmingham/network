$(document).on 'ready page:load', ->
  $('#confirm').hide()
  $('.select2').on 'select2:select', (e) ->
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