class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def answer(data)
    ActionCable.server.broadcast 'question_channel', answer: data['answer']
  end
end
