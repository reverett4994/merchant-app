# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#USE THIS LINE TO GET PAGE TO LOAD JAVA EVERYTIME

slideshow= ->
  $(".small_image img").click ->
    source=$(this).attr("src")
    $(".full_image").attr("src",source)


$(document).on 'turbolinks:load', ->
  slideshow()
