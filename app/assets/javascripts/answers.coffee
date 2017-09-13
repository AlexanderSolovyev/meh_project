# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener 'turbolinks:load', ->
  editlinks = document.querySelectorAll '.edit-answer-link'
  for i in [0...editlinks.length]
    editlinks[i].addEventListener 'click',myFunction
  document.querySelector('.new_answer').addEventListener 'ajax:success', (e) ->
    [data, status, xhr]= e.detail
    parsed = JSON.parse(xhr.responseText)
    answers = document.querySelector('.answers')
    answers.innerHTML = answers.innerHTML + answerHtml(parsed)
    document.querySelector('.error-answer').innerHTML = ' '
    document.querySelector('#answer_body').value = ''
  document.querySelector('.new_answer').addEventListener 'ajax:error', (e) ->
    [xhr, status, error] = e.detail
    document.querySelector('.error-answer').innerHTML = xhr
answerHtml = (parsed) ->
  text = "<p>#{parsed.body}</p>"
  if parsed.attachments.length > 0
    for i in [parsed.attachments.length]
      text = text + "<a href=#{parsed.attachments[i - 1].file.url}>#{parsed.attachments[i - 1].file.url}</a>"
  return text
