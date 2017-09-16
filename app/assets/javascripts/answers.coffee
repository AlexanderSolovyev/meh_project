# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener 'turbolinks:load', ->
  editlinks = document.querySelectorAll '.edit-answer-link'
  for i in [0...editlinks.length]
    editlinks[i].addEventListener 'click', hideEditForm

