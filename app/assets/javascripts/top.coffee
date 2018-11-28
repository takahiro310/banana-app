# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#cboxOverlay").fadeOut 100

  $('#request_create_image')
    .on 'ajax:complete', (event) ->
      response = event.detail[0].response
      $('#created_image').html(response)
      $("#cboxOverlay").fadeOut 100
      $(".loading").fadeOut 100
      return

  $('#form_submit')
    .on 'click', (event) ->
      $(".loading").show()
      $("#cboxOverlay").css("opacity", "0.3").show()
      return
