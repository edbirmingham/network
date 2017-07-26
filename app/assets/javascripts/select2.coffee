$(document).on 'ready page:load turbolinks:render', ->
  $('.select2').each (i, e) =>
    select = $(e)
    options =
      theme: 'bootstrap'
 
    if select.hasClass('ajax') # only add ajax functionality if this class is present
      options.ajax =
        dataType: 'json'
        data: (term) ->
          q: term
        processResults: (data) ->
          results: data
 
    select.select2(options)
