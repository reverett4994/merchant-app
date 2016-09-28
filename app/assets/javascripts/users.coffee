# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

email= ->
  $("#email_link").click ->
	  $("#email").fadeToggle() 

$(document).on 'turbolinks:load', ->
  email()
