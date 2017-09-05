class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    return unless @answer.user == current_user
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    return unless @answer.user == current_user
    @question = @answer.question
    @answer.destroy
  end
  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
