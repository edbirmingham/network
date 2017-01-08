$(document).on 'ready page:load', ->
  $('#return-button').hide()
  $('#confirm').hide()
  $('#update').hide()
  
  $('#member_ids').on 'select2:select', (e) ->
    $('#participation_member_id').val(e.params.data.id)
    $('#create').hide()
    $('#update').hide()
    $('#member_ids').html()
    $('#confirm').show()
    $('#first_name').text(e.params.data.first_name)
    $('#last_name').text(e.params.data.last_name)
    $('#phone').text(e.params.data.phone)
    $('#identity').text(e.params.data.identity)
    $('#email').text(e.params.data.email)
    
    # Revert/clear create form
  $('#unconfirm, #return-button').on 'click', ->
    $('#confirm').hide()
    $('#return-button').hide()
    $('#member_ids').val('').trigger('change')
    $('#create :input').val('')
    $('#member_heading').text('Create Member')
    $('#new_edit_submit').val('Create Member')
    $('#member_identity').val('Student').trigger('change')
    $('#graduating').show()
    $('#school').show()
    $('#member_school_id').val('').trigger('change')
    $('#member_graduating_class_id').val('').trigger('change')
    $('#create').show()
    
  $('#member_identity').on 'select2:select', (e) ->
    selected = e.params.data.text
    if selected is 'Student'
      $('#school').show() 
      $('#graduating').show() 
    else if selected is 'Parent' or selected is 'Educator'
      $('#school').show() 
      $('#graduating').hide() 
    else
      $('#school').hide() 
      $('#graduating').hide() 
      
  # Alter create form for edit, fill with member values
  $('#update-signup').on 'click', ->
    $('#confirm').hide() 
    $('#create').show()
    $('#member_heading').text('Edit Member')
    $('#new_edit_submit').val('Update Member')
    $('#return-button').show()
    data = $('#member_ids').select2('data')
    member = data[0]
    $('#member_id').val(member.id)
    $('#member_first_name').val(member.first_name)
    $('#member_last_name').val(member.last_name)
    $('#member_phone').val(member.phone)
    $('#member_email').val(member.email)
    $('#member_identity').val(member.identity).trigger('change')
    if member.identity is 'Student'
      $('#graduating').show() 
      $('#school').show() 
      $('#member_school_id').val(member.school_id).trigger('change')
      $('#member_graduating_class_id').val(member.graduating_class_id).trigger('change')
    else if member.identity is 'Parent' or member.identity is 'Educator'
      $('#school').show() 
      $('#graduating').hide() 
      $('#member_school_id').val(member.school_id).trigger('change')
    else
      $('#school').hide() 
      $('#graduating').hide() 
    
      