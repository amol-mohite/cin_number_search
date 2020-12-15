# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.close_modal, .modal-background').click (e) ->
  	$('.modal').removeClass('is-active')
  $('.clear_history').click (e) ->
    $('.modal').addClass('is-active')