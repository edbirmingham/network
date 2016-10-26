$(document).on 'ready page:load', ->
  client = new ZeroClipboard($('.copy_button'))
  $('.copy_button').tooltip()