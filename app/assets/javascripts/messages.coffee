$(document).on 'ready page:load turbolinks:load', ->
  if $('#message_body').summernote
    $('#message_body').summernote('justifyLeft')
