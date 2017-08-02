$(document).on "turbolinks:before-cache", ->
  $('.select2-input').select2('destroy')


$(document).on 'ready page:load turbolinks:load', ->
  $('.select2').each (i, e) =>
    select = $(e)
    options =
      tags: true
      theme: 'bootstrap'
      tokenSeparators: [",", " "],
      createTag: (params) ->
        if $(@.$element).attr('data-tags') != 'true'
          return null

        if params.term.indexOf('@') == -1
          return null

        return {
          id: params.term,
          text: params.term
        }
        
 
    if select.hasClass('ajax') # only add ajax functionality if this class is present
      options.ajax = (
        delay: 250,
        dataType: 'json'
        data: (term) ->
          q: term
        processResults: (data) ->
          results: data
      ) 
    select.select2(options)
