$(document).on 'ready page:load turbolinks:load', ->
  
  $('.unlock-task').change ->
    if $(this).is(':checked')
      $(this).parents('.input-form').find(':input').filter('.js-proj-task-form').prop('disabled', false)
    else
      $(this).parents('.input-form').find(':input').filter('.js-proj-task-form').prop('disabled', true)

  $('.select2.common').on 'select2:select', ->
    select_option = $(this).select2('data')[0].text
    $(this).parents('.input-form').find(':input').filter('.js-task-name').val(select_option)
    
  $('#select2-project_owner_id-container').on 'select2:select', ->
    select_option = $(this).select2('data').text()
    
  $('#proj-due-date').datetimepicker({
      showClear: true,
      format: 'YYYY-MM-DD',
      useCurrent: false
    })
    
  $('.js-complete-project-btn').closest('form').on 'ajax:success', (event, data) ->
    event.preventDefault()
    $(this).replaceWith("<h3>Completed</h3>")
    
           
    
    
      
