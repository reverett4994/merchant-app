# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#USE THIS LINE TO GET PAGE TO LOAD JAVA EVERYTIME




email= ->
  $("#email_link").click ->
	  $("#email").fadeToggle()
  $("#email_link").click ->    
	  $('html, body').animate({
      scrollTop: $("#email").offset().top
    }, 1000);
  $("#comments_by").click ->
    $("#comments").fadeToggle()
  $("#comments_by").click ->
	  $('html, body').animate({
      scrollTop: $("#comments").offset().top
    }, 1000);
  $("#recent_comments_nav").click ->
    $("#recent_comments").fadeToggle()
  $("#recent_comments_nav").click ->
	  $('html, body').animate({
      scrollTop: $("#recent_comments").offset().top
    }, 1000);
  $("#current_offers").click ->
    $("#offers").fadeToggle()
  $("#current_offers").click ->
	  $('html, body').animate({
      scrollTop: $("#offers").offset().top
    }, 1000);
slideshow= ->
  $(".small_image img").click ->
    source=$(this).attr("src")
    $(".full_image").attr("src",source)

fullimage= ->
  # Get the modal
  modal = document.getElementById('myModal')
  # Get the image and insert it inside the modal - use its "alt" text as a caption
  img = document.getElementById('myImg')
  modalImg = document.getElementById('img01')

  captionText = document.getElementById('caption')

  img.onclick = ->
    modal.style.display = 'block'
    modalImg.src = @src
    captionText.innerHTML = @alt
    return

  # Get the <span> element that closes the modal
  span = document.getElementsByClassName('close')[0]
  # When the user clicks on <span> (x), close the modal

  span.onclick = ->
    modal.style.display = 'none'
    return

$(document).on 'turbolinks:load', ->
  email()
  slideshow()
  fullimage()
  initMap()
