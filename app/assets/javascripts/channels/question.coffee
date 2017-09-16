App.question = App.cable.subscriptions.create "QuestionChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    (document.querySelector '.answers').innerHTML = data["answers"]
    (document.querySelector '#answer_body').value = ''

  answer: (answer) ->
    @perform 'answer', answer: answer

